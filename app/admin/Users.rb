ActiveAdmin.register User do
  permit_params :email, :encrypted_password, :address, :city, :postal_code, :province
end
