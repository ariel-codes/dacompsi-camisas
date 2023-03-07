class ApplicationController < ActionController::Base
  before_action :set_cart
  before_action :set_buyer

  private

  def set_cart
    @cart = Cart.open.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    session.delete(:cart_id)
  end

  def set_buyer
    @buyer = Buyer.find(session[:buyer_id])
  rescue ActiveRecord::RecordNotFound
    session.delete(:buyer_id)
  end
end
