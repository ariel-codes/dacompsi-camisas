class CampaignsController < ApplicationController
  def index
    @campaigns = Campaign.active.all
    ahoy.track "index_campaigns", campaigns: @campaigns.map(&:name)
  end

  def show
    @campaign = Campaign.active.find(params[:id])
    ahoy.track "view_campaign", campaign_id: @campaign.id
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end
end
