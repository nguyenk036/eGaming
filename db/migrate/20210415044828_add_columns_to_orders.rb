class AddColumnsToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :address, :string
    add_column :orders, :city, :string
    add_column :orders, :postal_code, :string
    add_reference :orders, :province, null: false, foreign_key: true
  end
end
