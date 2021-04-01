class AddDeveloperToGames < ActiveRecord::Migration[6.1]
  def change
    add_reference :games, :developer, null: false, foreign_key: true
  end
end
