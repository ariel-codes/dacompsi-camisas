class ApplicationController < ActionController::Base
  before_action :set_cart
  before_action :set_buyer

  def logout
    session.clear
    redirect_to root_path, status: :see_other
  end

  private

  def set_cart
    @cart = Cart.open.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    session.delete(:cart_id)
  end

  def require_cart
    @cart ||= Cart.create!
    session[:cart_id] = @cart.id
  end

  def set_buyer
    @buyer = Buyer.find(session[:buyer_id])
  rescue ActiveRecord::RecordNotFound
    session.delete(:buyer_id)
  end

  def require_buyer
    redirect_to root_path, status: :see_other unless @buyer
  end

  def current_user
    @buyer
  end
end
