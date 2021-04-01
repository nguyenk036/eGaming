class AddGstToGameOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :game_orders, :GST, :float
  end
end
