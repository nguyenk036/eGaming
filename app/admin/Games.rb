ActiveAdmin.register Game do
  permit_params :title, :developer_id, :metascore, :price
end
