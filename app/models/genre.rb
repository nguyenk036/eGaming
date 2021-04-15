class Genre < ApplicationRecord
  # has_many :game_genres, dependent: :delete_all
  # has_many :games, through: :game_genres
  has_many :games

  validates :title, uniqueness: true, presence: true
end
