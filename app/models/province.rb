class Province < ApplicationRecord
  has_many :users

  validates :name, :code, uniqueness: true, presence: true
  validates :PST, numericality: true
end
