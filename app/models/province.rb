class Province < ApplicationRecord
  validates :name, :code, uniqueness: true, presence: true
  validates :PST, numericality: true
end
