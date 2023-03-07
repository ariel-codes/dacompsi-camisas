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
    Buyer.transaction do
      @buyer = Buyer.create!(buyer_params)
      session[:buyer_id] = @buyer.id
      @order = Order.create!(cart: @cart, buyer: @buyer, total_price: @cart.total_price)
      OrderMailer.with(order: @order, buyer: @buyer).confirmation.deliver_later
    end

    redirect_to order_path(@order), status: :see_other
  end

  private

  def buyer_params
    params.require(:buyer).permit(:name, :email, :telephone)
  end
end
