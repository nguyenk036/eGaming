class HomeController < ApplicationController
  def index
    @games_limit = Game.limit(50)
    @games = Game.all
    @genres = Genre.limit(10)
  end

  def show
    @game = Game.find(params[:id])
  end
end
