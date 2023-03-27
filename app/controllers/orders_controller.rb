class OrdersController < ApplicationController
  include TokenSession

  before_action :require_cart, only: :create
  before_action :require_buyer, except: [:create, :public_link]
  before_action :retrieve_session_from_token, only: :public_link

  def index
    @orders = @buyer.orders
    ahoy.track "index_orders", orders: @orders.map(&:id)
  end

  def show
    @order = @buyer.orders.find(params[:id])
    ahoy.track "view_order", order_id: @order.id, public_link: false
  end

  def public_link
    ahoy.track "view_order", order_id: @order.id, public_link: true
    render "show"
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, status: :see_other
  end

  def create
    return redirect_to cart_path if @cart.empty?

    try_count = 0
    init_point = nil

    begin
      if (@buyer = Buyer.find_by(email: buyer_params[:email]) || Buyer.find_by(telephone: buyer_params[:telephone]))
        @buyer.update!(buyer_params)
      else
        @buyer = Buyer.create!(buyer_params)
      end

      Order.transaction do
        @order = Order.create!(cart: @cart, buyer: @buyer, total_price: @cart.total_price)
        init_point = PaymentService.new(@order).create_payment(
          notification_url: payment_notification_ipn_url(@order, token: @order.token, source_news: :ipn),
          back_url: payment_notification_after_redirect_url(@order, token: @order.token)
        )
      end
    rescue SQLite3::BusyException
      if try_count > 3
        @buyer&.destroy! if @buyer&.orders&.empty?
        flash[:error] = "Não foi possível processar o seu pedido. Por favor, tente novamente mais tarde."
        return redirect_to cart_path
      else
        try_count += 1
        retry
      end
    end

    session[:buyer_id] = @buyer.id
    redirect_to init_point, allow_other_host: true, status: :see_other
  end

  private

  def buyer_params
    params.require(:buyer).permit(:name, :email, :telephone)
  end
end
