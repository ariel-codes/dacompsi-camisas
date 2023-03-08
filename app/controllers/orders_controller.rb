class OrdersController < ApplicationController
  include TokenSession

  before_action :require_buyer, except: [:create, :public_link]
  before_action :retrieve_session_from_token, only: :public_link

  def index
    @orders = @buyer.orders
  end

  def show
    @order = @buyer.orders.find(params[:id])
  end

  def public_link
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
        notification_url: payment_notification_ipn_url(@order, token: @order.token, source_news: :ipn),
        back_url: payment_notification_after_redirect_url(@order, token: @order.token)
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
