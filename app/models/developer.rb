class Developer < ApplicationRecord
  has_many :games

  validates :name, uniqueness: true, presence: true
end
