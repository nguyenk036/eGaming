class AddCodeToProvinces < ActiveRecord::Migration[6.1]
  def change
    add_column :provinces, :code, :string
  end
end
