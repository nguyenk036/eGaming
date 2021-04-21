class CheckoutController < ApplicationController
  before_action :authenticate_user!

  def index
    @subtotal = 0
    @pst_rate = Province.find(current_user.province_id).PST
    @gst_rate = Province.find(current_user.province_id).GST
    @user_province = Province.find(current_user.province_id).code
    @user = current_user

    cart.each do |game|
      @subtotal += game[0].price * game[1]
    end

    @pst = @subtotal * @pst_rate
    @gst = @subtotal * @gst_rate
    @total = @subtotal + @gst + @pst
  end

  def update
    @user = User.find_by(id: current_user.id)
    @user.update(user_params)
    redirect_to checkout_index_path
  end

  def create
    cart_items = []
    @subtotal = 0
    @pst_rate = Province.find(current_user.province_id).PST
    @gst_rate = Province.find(current_user.province_id).GST
    @user_province = Province.find(current_user.province_id).code
    @user = current_user

    cart.each do |game|
      @subtotal += game[0].price * game[1]
    end

    @pst = @subtotal * @pst_rate
    @gst = @subtotal * @gst_rate

    session[:cart].each do |game|
      cart_items << { name:     Game.find(game[0]).title,
                      amount:   (Game.find(game[0]).price * 100).to_i,
                      currency: "cad",
                      quantity: game[1] }
    end

    unless Province.find(current_user.province_id).PST.nil?
      cart_items << { name:     "PST/HST",
                      amount:   (@pst * 100).to_i,
                      currency: "cad",
                      quantity: 1 }
    end

    if @gst.positive?
      cart_items << { name:     "GST",
                      amount:   (@gst * 100).to_i,
                      currency: "cad",
                      quantity: 1 }
    end

    @session = Stripe::Checkout::Session.create(
      payment_method_types: ["card"],
      success_url:          "#{checkout_success_url}?session_id={CHECKOUT_SESSION_ID}",
      cancel_url:           checkout_cancel_url,
      line_items:           cart_items
    )

    respond_to do |format|
      format.js
    end
  end

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
  end

  def cancel
    # An error occurred with the payment
  end

  def checkout_params
    params.permit(:order_id, :pst, :gst)
  end

  def user_params
    params.permit(:province_id, :address, :postal, :city)
  end
end
