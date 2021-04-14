class CheckoutController < ApplicationController
  def index
    @provinces = Province.all
  end
end
