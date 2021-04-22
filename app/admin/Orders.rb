ActiveAdmin.register Order do
  permit_params :paid_amount, :address, :city, :postal_code, :province_id, :stripe_payment_id, :paid

  show do
    attributes_table do
      row :id
      row :user
      row :paid_amount
      row :created_at
      row :address
      row :city
      row :postal_code
      row :province_id
      row :stripe_payment_id
      row :paid
      row :games
      row :game_orders
    end
  end
end
