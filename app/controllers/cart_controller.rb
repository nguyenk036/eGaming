class CartController < ApplicationController
  before_action :authenticate_user!
  protect_from_forgery with: :null_session

  def create
    id = params[:game_id].to_i
    session[:cart] << [id, 1]
    game = Game.find(id)

    flash[:notice] = "Added #{game.title} to the cart."

    redirect_to root_path
  end

  def destroy
    id = params[:id].to_i

    session[:cart].each_with_index do |game_array, index|
      session[:cart].delete_at(index) if game_array[0] == id
    end

    game = Game.find(id)
    flash[:notice] = "Removed #{game.title} from the cart."

    redirect_to root_path
  end

  def increment
    id = params[:cart_id].to_i

    session[:cart].each do |game_array|
      game_array[1] += 1 if game_array[0] == id
    end

    redirect_to checkout_index_path
  end

  def decrement
    id = params[:cart_id].to_i

    session[:cart].each do |game_array|
      game_array[1] -= 1 if game_array[0] == id
    end

    redirect_to checkout_index_path
  end
end
