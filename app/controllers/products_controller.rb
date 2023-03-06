class ProductsController < ApplicationController
  def show
    @campaign = Campaign.find_by(id: params[:campaign_id])
    if @campaign
      @product = @campaign.products.find(params[:id])
    else
      @product = Product.find(params[:id])
      @campaign ||= @product.campaigns.active.first
    end
  end
end
