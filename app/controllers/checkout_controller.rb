class CheckoutController < ApplicationController
  before_action :authenticate_user!

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

  def create
    cart_items = []
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
      format.js # render app/views/checkout/create.js.erb
    end
  end

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
    # @payment_intent_id = Stripe::PaymentIntent.retrieve(@session.payment_intent.id)
    # @payment_amount_received = Stripe::PaymentIntent.retrieve(@session.payment_intent.original_values.payment_amount_received)
    # @payment_paid = Stripe::PaymentIntent.retrieve(@session.payment_intent.original_values.charges.data.paid)
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
