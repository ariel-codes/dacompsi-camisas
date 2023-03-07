class ApplicationController < ActionController::Base
  before_action :set_cart, :set_buyer

  private

  def set_cart
    @cart = Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    session.delete(:buyer_id)
  end

  def set_buyer
    @buyer = Buyer.find(session[:buyer_id])
  rescue ActiveRecord::RecordNotFound
    session.delete(:buyer_id)
  end
end
