class CartController < ApplicationController
  before_action :authenticate_user!

  # Add to cart
  def create
    id = params[:game_id].to_i
    session[:cart] << [id, 1] # Add array of gameID with a default qty of 1 into session
    game = Game.find(id)

    flash[:notice] = "Added #{game.title} to the cart."

    redirect_to root_path
  end

  # Remove from cart
  def destroy
    id = params[:id].to_i

    # Loop cart to find item that matches ID, then delete the item array at the appropriate index
    session[:cart].each_with_index do |game_array, index|
      session[:cart].delete_at(index) if game_array[0] == id
    end

    game = Game.find(id)
    flash[:notice] = "Removed #{game.title} from the cart."

    redirect_to root_path
  end

  # Increase qty
  def increment
    id = params[:cart_id].to_i

    session[:cart].each do |game_array|
      game_array[1] += 1 if game_array[0] == id
    end

    redirect_to checkout_index_path
  end

  # Decrease qty
  def decrement
    id = params[:cart_id].to_i

    session[:cart].each do |game_array|
      game_array[1] -= 1 if game_array[0] == id
    end

    redirect_to checkout_index_path
  end
end
