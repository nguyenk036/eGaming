class RemoveStripePaymentIdFromOrders < ActiveRecord::Migration[6.1]
  def change
    remove_column :orders, :stripe_payment_id, :integer
  end
end
