class Order < ApplicationRecord
  belongs_to :user

  has_many :game_orders, dependent: :delete_all
  has_many :games, through: :game_orders

  validates :paid_amount, presence: true
  validates :paid_amount, numericality: true

  def self.province_name(id); end
end
