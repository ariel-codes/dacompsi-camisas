class OrdersController < ApplicationController
  before_action :require_buyer

  def index
    @orders = @buyer.orders
  end

  def show
    @order = @buyer.orders.find(params[:id])
  end

  private

  def require_buyer
    redirect_to root_path, status: :see_other unless @buyer
  end
end
