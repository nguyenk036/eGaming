ActiveAdmin.register Province do
  permit_params :name, :PST, :GST, :code
end
