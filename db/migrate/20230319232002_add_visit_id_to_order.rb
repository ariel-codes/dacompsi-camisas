class AddVisitIdToOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :ahoy_visit_id, :string
  end
end
