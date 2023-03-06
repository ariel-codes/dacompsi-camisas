class CampaignsController < ApplicationController
  def index
    @campaigns = Campaign.active.all
  end

  def show
    @campaign = Campaign.active.find(params[:id])
  end
end
