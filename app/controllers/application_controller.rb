class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

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

  def initialize_session
    session[:cart] ||= []
  end

  def cart
    cart ||= []

    session[:cart].each do |game_array|
      game = Game.find(game_array[0])
      cart << [game, game_array[1]]
    end

    cart
  end
end
