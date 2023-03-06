class ProductsController < ApplicationController
  def index
  end

  def show
    @campaign = Campaign.find(params[:campaign_id])
    @product = @campaign.products.find(params[:id])
  end
end
