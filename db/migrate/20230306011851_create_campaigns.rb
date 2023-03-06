class CreateCampaigns < ActiveRecord::Migration[7.0]
  def change
    create_table :campaigns do |t|
      t.string :name, null: false
      t.date :start, null: false
      t.date :end, null: false

      t.timestamps
    end
  end
end
