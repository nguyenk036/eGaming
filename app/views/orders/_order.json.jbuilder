json.extract! order, :id, :user_id, :game_id, :date, :paid_amount, :created_at, :updated_at
json.url order_url(order, format: :json)
