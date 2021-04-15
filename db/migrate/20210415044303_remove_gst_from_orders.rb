class RemoveGstFromOrders < ActiveRecord::Migration[6.1]
  def change
    remove_column :orders, :GST, :float
  end
end
