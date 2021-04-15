class RemoveGenreIdFromGames < ActiveRecord::Migration[6.1]
  def change
    remove_column :games, :genre_id, :integer
  end
end
