class AddAhoyVisitIdToCart < ActiveRecord::Migration[7.0]
  def change
    add_column :carts, :ahoy_visit_id, :string
  end
end
