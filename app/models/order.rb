class Order < ApplicationRecord
  belongs_to :user
  belongs_to :game

  validates :date, :paid_amount, presence: true
  validates :paid_amount, numericality: true
end
