class CheckoutController < ApplicationController
  before_action :authenticate_user!

  def new
    @order = Order.new
  end

  def index
    @subtotal = 0
    @pst_rate = Province.find(current_user.province_id).PST
    @gst_rate = 0.05
    @user_province = Province.find(current_user.province_id).code
    @user = current_user

    cart.each do |game|
      @subtotal += game[0].price * game[1]
    end

    @pst = if @pst_rate.nil?
             0
           else
             @subtotal * @pst_rate
           end

    @gst = if %w[NB NL NS ON PE].include? @user_province
             0
           else
             @subtotal * @gst_rate
           end

    @total = @subtotal + @gst + @pst
  end

  def update
    logger.debug(user_params)
    @user = User.find_by(id: current_user.id)
    @user.update(user_params)
    redirect_to checkout_index_path
  end

  def user_params
    params.permit(:province_id, :address, :postal, :city)
  end
end
