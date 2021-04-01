class AddPstToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :PST, :float
  end
end
