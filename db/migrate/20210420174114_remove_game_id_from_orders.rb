class RemoveGameIdFromOrders < ActiveRecord::Migration[6.1]
  def change
    remove_column :orders, :game_id, :integer
  end
end
