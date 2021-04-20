class OrdersController < ApplicationController
  before_action :set_order, only: %i[show edit update destroy]

  # GET /orders or /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1 or /orders/1.json
  def show; end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit; end

  # POST /orders or /orders.json
  def create
    @user = current_user
    @game_order = nil
    @order = Order.create(
      user_id:           @user.id,
      paid_amount:       params[:paid_amount],
      address:           @user.address,
      city:              @user.city,
      postal_code:       @user.postal_code,
      province_id:       @user.province_id,
      stripe_payment_id: params[:stripe_payment_id]
    )

    if @order&.valid?
      cart.each do |game|
        @game_order = GameOrder.create(
          game_id:  game[0].id,
          order_id: @order,
          quantity: game[1],
          price:    game[0].price,
          PST:      @user.province_id.PST
        )
      end
    end

    if @order&.valid? && !@game_order.nil?
      flash[:notice] = "Order successfully placed!"

      session[:cart] = []

      redirect_to root
    else
      flash[:notice] = "Something went wrong with the order placement process :("

      redirect_to checkout_index_path
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update; end

  # DELETE /orders/1 or /orders/1.json
  def destroy; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
end
