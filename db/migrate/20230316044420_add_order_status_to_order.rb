class AddOrderStatusToOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :order_status, :string
  end
end
