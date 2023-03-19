class ProductsController < ApplicationController
  before_action :set_product, :set_carousel_index

  def show
  end

  def carousel_move
    @carousel_index += if params[:direction] == "prev"
      -1
    elsif params[:direction] == "next"
      1
    end
    @carousel_index = @carousel_index % @product.images.size

    render "show"
  end

  private

  def set_carousel_index
    @carousel_index = params[:carousel_index].to_i
  end

  def set_product
    @campaign = Campaign.find_by(id: params[:campaign_id])
    if @campaign
      @product = @campaign.products.find(params[:id])
    else
      @product = Product.find(params[:id])
      @campaign ||= @product.campaigns.active.first
    end
  end
end
