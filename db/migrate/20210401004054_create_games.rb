class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.string :title
      t.references :developer, null: false, foreign_key: true
      t.references :genre, null: false, foreign_key: true
      t.int :metascore
      t.float :price

      t.timestamps
    end
  end
end
