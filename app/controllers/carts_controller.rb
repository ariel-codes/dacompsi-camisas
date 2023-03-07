class CartsController < ApplicationController
  before_action :require_cart

  def show
    @continue_campaign = if params[:continue].present?
      Campaign.active.find_by(id: params[:continue])
    end
  end

  def add_product
    cart_product = @cart.cart_products.create!(product_params)

    redirect_to cart_path(continue: cart_product.product.campaigns.active.first.id), status: :see_other
  end

  def change_quantity
    @cart_product = @cart.cart_products.find(params[:id])
    @cart_product.change_quantity(params[:change].to_i)

    respond_to do |format|
      format.turbo_stream { render "change_quantity" }
      format.html { render "show" }
    end
  end

  def checkout
    @buyer ||= Buyer.new
  end

  private

  def product_params
    product = Product.find(params[:product][:product_id])
    params.require(:product).permit(:product_id, :quantity,
      variations: product.variations.keys.map(&:to_sym))
  end
end
