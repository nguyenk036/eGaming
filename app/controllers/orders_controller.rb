class OrdersController < ApplicationController
  before_action :set_order, only: %i[show edit update destroy]

  def index
    @orders = Order.where(user_id: current_user.id)
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    @user = current_user
    @successful_game_order = false

    @order = Order.new(
      user_id:           @user.id,
      paid_amount:       params[:paid_amount].to_f,
      address:           @user.address,
      city:              @user.city,
      postal_code:       @user.postal_code,
      province_id:       @user.province_id,
      stripe_payment_id: params[:stripe_payment_id],
      paid:              params[:paid]
    )

    if @order&.valid?
      @order.save

      cart.each do |game|
        @game_order = @order.game_orders.create(
          game_id:  game[0].id,
          quantity: game[1],
          price:    game[0].price,
          PST:      Province.find(@user.province_id).PST,
          GST:      Province.find(@user.province_id).GST
        )

        @successful_game_order = @game_order&.valid?
      end
    end

    if @successful_game_order != false
      flash[:notice] = "Order successfully placed!"
      session[:cart] = []

      redirect_to :root
    else
      flash[:notice] = "Something went wrong :("

      redirect_to checkout_index_path
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.permit(:paid_amount, :stripe_payment_id, :paid)
  end
end
