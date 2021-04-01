class CartController < ApplicationController
  def create
    id = params[:game_id].to_i
    session[:cart] << id
    game = Game.find(id)

    flash[:notice] = "Added #{game.title} to the cart."

    redirect_to root_path
  end

  def destroy
    id = params[:game_id].to_i
    session[:cart].delete(id)
    game = Game.find(id)

    flash[:notice] = "Removed #{game.title} from the cart."

    redirect_to root_path
  end
end
