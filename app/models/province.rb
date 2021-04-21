class Province < ApplicationRecord
  validates :name, :code, uniqueness: true, presence: true
  validates :PST, numericality: true

  def self.province_name(id)
    Province.find(id).name
  end
end
