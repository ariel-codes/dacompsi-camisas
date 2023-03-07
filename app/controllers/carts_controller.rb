class CartsController < ApplicationController
  before_action :require_cart

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
      format.turbo_stream { render "change_quantity" }
      format.html { redirect_to cart_path, status: :see_other }
    end
  end

  def checkout
    @buyer = Buyer.new
  end

  def order
    Buyer.transaction do
      @buyer = Buyer.create!(buyer_params)
      session[:buyer_id] = @buyer.id
      @order = Order.create!(cart: @cart, buyer: @buyer, total_price: @cart.total_price)
      @cart.close!
    end

    redirect_to order_path(@order), status: :see_other
  end

  private

  def require_cart
    @cart ||= Cart.create!
    session[:cart_id] = @cart.id
  end

  def product_params
    product = Product.find(params[:product][:product_id])
    params.require(:product).permit(:product_id, :quantity,
      variations: product.variations.keys.map(&:to_sym))
  end

  def buyer_params
    params.require(:buyer).permit(:name, :email, :telephone)
  end
end
