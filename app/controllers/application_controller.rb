class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :initialize_session
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :cart

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:email, :password, :password_confirmation, :address, :city, :postal_code)
    end

    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:email, :password, :password_confirmation, :address, :city, :postal_code)
    end
  end

  private

  def initialize_session
    session[:cart] ||= []
  end

  def cart
    Game.find(session[:cart])
  end
end
