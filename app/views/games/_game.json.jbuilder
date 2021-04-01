json.extract! game, :id, :title, :developer_id, :genre_id, :metascore, :price, :created_at, :updated_at
json.url game_url(game, format: :json)
