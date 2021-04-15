class DropGameGenreTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :game_genres
  end
end
