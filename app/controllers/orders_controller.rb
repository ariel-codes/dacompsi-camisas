class OrdersController < ApplicationController
  before_action :require_buyer, except: [:create, :public_link]

  def index
    @orders = @buyer.orders
  end

  def show
    @order = @buyer.orders.find(params[:id])
  end

  def public_link
    @order = Order.find_by!(token: params[:token])
    @buyer = @order.buyer
    session[:buyer_id] = @buyer.id
    render "show"
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, status: :see_other
  end

  def create
    init_point = nil
    Buyer.transaction do
      @buyer = Buyer.create!(buyer_params)
      session[:buyer_id] = @buyer.id

      @order = Order.create!(cart: @cart, buyer: @buyer, total_price: @cart.total_price)

      preference_id, init_point = PaymentService.new(@order).create_payment(
        order_url(@order), notify_order_url(@order, token: @order.token, source_news: :ipn)
      )
      @order.update!(payment_preference_id: preference_id)
    end

    OrderMailer.with(order: @order, buyer: @buyer).confirmation.deliver_later

    redirect_to init_point, allow_other_host: true, status: :see_other
  end

  private

  def buyer_params
    params.require(:buyer).permit(:name, :email, :telephone)
  end
end
