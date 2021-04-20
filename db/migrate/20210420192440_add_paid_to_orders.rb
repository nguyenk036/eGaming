class AddPaidToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :stripe_payment_id, :string
    add_column :orders, :paid, :boolean
  end
end
