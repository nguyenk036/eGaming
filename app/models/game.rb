class Game < ApplicationRecord
  paginates_per 25

  has_many :game_genres, dependent: :delete_all
  has_many :genres, through: :game_genres

  has_many :game_orders, dependent: :delete_all
  has_many :orders, through: :game_orders

  belongs_to :developer

  validates :title, uniqueness: true, presence: true
  validates :meatscore, numericality: { only_integer: true }
  validates :price, numericality: true

  def self.search(search)
    if search
      game = where("LOWER(games.title) LIKE ?", "#{search.downcase}%")

      if game
        game = where("LOWER(games.title) LIKE ?", "#{search.downcase}%")
      else
        Game.all
      end
    else
      Game.all
    end
  end
end
