class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  before_action :initialize_session
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :cart

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:email, :password, :password_confirmation, :address, :city, :postal_code,
               :province_id)
    end

    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:email, :password, :password_confirmation, :address, :city, :postal_code,
               :province_id, :current_password)
    end
  end

  private

  # Initializing session
  def initialize_session
    session[:cart] ||= []
  end

  # Method to create a new array holding game object and quantity in an array
  def cart
    shopping_cart = []

    # Each item in session[:cart] is an array of [gameID, qty]
    session[:cart].each do |game_array|
      game = Game.find(game_array[0])
      shopping_cart << [game, game_array[1]]
    end

    shopping_cart
  end
end
