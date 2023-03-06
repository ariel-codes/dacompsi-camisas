class CreateJoinTableProductsCampaigns < ActiveRecord::Migration[7.0]
  def change
    create_join_table :products, :campaigns do |t|
      t.index [:product_id, :campaign_id]
      t.index [:campaign_id, :product_id]
    end
  end
end
