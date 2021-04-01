# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "faker"

GameGenre.delete_all
GameOrder.delete_all
Game.delete_all
Genre.delete_all
Order.delete_all
Developer.delete_all
User.delete_all

100.times do
  dev = Developer.find_or_create_by(
    name: Faker::Name.name
  )

  game = Game.find_or_create_by(
    title:     Faker::Game.title,
    developer: dev,
    metascore: 99,
    price:     9.99
  )

  gen = Genre.find_or_create_by(
    title: Faker::Game.genre
  )

  GameGenre.find_or_create_by(
    game:  game,
    genre: gen
  )
end

# if Rails.env.development?
#   AdminUser.create!(email: "admin@example.com", password: "password",
#   password_confirmation: "password")
# end
