class AddGstToProvinces < ActiveRecord::Migration[6.1]
  def change
    add_column :provinces, :GST, :float
  end
end
