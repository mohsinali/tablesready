class ReservationsController < ApplicationController
  before_action :set_reservation,only: [:edit,:update,:destroy,:change_status]

  def index
    @reservations = Reservation.by_restaurant(my_restaurant)
    @reservation = Reservation.new(size: 2,restaurant_id: my_restaurant.id,booking_date: Date.today)
  end

  def new
    @reservation = Reservation.new(size: 2,restaurant_id: my_restaurant.id,booking_date: Date.today)
  end

  def create
    @reservation = Reservation.create(reservation_params)
    respond_to do |format|
      format.js {render layout: false}
    end
  end

  def edit
    respond_to do |format|
      format.js {render layout: false}
    end
  end

  def update
    @reservation.update(reservation_params)
    respond_to do |format|
      format.js {render layout: false}
    end
  end

  def change_status
    @reservation.send("#{params[:status]}!")
    respond_to do |format|
      format.js {render layout: false}
    end
  end

  def destroy
    @reservation.cancelled!
    @reservation.destroy
    respond_to do |format|
      format.js {render layout: false}
    end
  end

  private

    def reservation_params
      params.require(:reservation).permit(:booking_date,:booking_time,:size,:phone,:party_name,:notes,:restaurant_id)
    end

    def set_reservation
      @reservation = Reservation.find(params[:id])
    end
end
