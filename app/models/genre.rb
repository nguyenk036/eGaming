class Genre < ApplicationRecord
  has_many :game_genres
  has_many :games, through: :game_genres

  validates :title, uniqueness: true, presence: true
end
