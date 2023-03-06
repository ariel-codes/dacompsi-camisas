class CartsController < ApplicationController
  before_action :set_cart

  def show
  end

  def add_product
    @cart.cart_products.create!(product_params)

    redirect_to cart_path, status: :see_other
  end

  def change_quantity
    @cart_product = @cart.cart_products.find(params[:id])
    @cart_product.increment!(:quantity, params[:change].to_i)

    respond_to do |format|
      format.turbo_stream { render "carts/change_quantity" }
      format.html { redirect_to cart_path, status: :see_other }
    end
  end

  private

  def set_cart
    @cart = Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    @cart = Cart.create!
    session[:cart_id] = @cart.id
  end

  def product_params
    product = Product.find(params[:product][:product_id])
    params.require(:product).permit(:product_id, :quantity,
      variations: product.variations.keys.map(&:to_sym))
  end
end
