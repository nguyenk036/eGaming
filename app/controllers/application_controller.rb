class ApplicationController < ActionController::Base
  before_action :initialize_session
  helper_method :cart

  private

  def initialize_session
    session[:cart] ||= []
  end

  def cart
    Game.find(session[:cart])
  end
end
