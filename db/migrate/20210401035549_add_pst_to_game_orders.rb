class AddPstToGameOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :game_orders, :PST, :float
  end
end
