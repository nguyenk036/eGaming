class Game < ApplicationRecord
  paginates_per 25

  # has_many :game_genres, dependent: :delete_all
  # has_many :genres, through: :game_genres
  belongs_to :genre

  has_many :game_orders, dependent: :delete_all
  has_many :orders, through: :game_orders

  belongs_to :developer

  validates :title, uniqueness: true, presence: true
  validates :metascore, numericality: { only_integer: true }
  validates :price, numericality: true

  def self.search(search, genre = nil)
    if search && genre.nil?
      game = where("LOWER(games.title) LIKE ?", "#{search.downcase}%")

      if game
        game = where("LOWER(games.title) LIKE ?", "#{search.downcase}%")
      else
        Game.all
      end
    elsif search && !genre.nil?
      game = where("LOWER(games.title) LIKE ?",
                   "#{search.downcase}%").where(genre_id: genre[:id].to_i)

      if game
        game = where("LOWER(games.title) LIKE ?",
                     "#{search.downcase}%").where(genre_id: genre[:id].to_i)
      else
        Game.all
      end
    elsif !search && !genre.nil?
      genre_filter(genre)
    else
      Game.all
    end
  end

  def self.genre_filter(genre)
    if genre
      game = where(genre_id: genre[:id].to_i)

      if game
        game = where(genre_id: genre[:id].to_i)
      else
        Game.all
      end
    else
      Game.all
    end
  end
end
