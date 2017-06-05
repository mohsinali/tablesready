class WalkInsController < ApplicationController

  before_action :set_walkin,only: [:edit,:update,:destroy]

  def index
    @walk_ins = WalkIn.all
    @walk_in = WalkIn.new(size: 2,restaurant_id: my_restaurant.id,booking_date: Date.today)
  end

  def new
    @walk_in = WalkIn.new(size: 2,restaurant_id: my_restaurant.id,booking_date: Date.today)
  end

  def create
    @walk_in = WalkIn.create(walk_in_params)
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
    @walk_in.update(walk_in_params)
    respond_to do |format|
      format.js {render layout: false}
    end
  end

  def destroy
  end

  private

    def walk_in_params
      if params[:time_in_minutes].present?
        time_in_minutes = params[:time_in_minutes].to_i
        params[:walk_in][:booking_time] = params[:walk_in][:booking_time].to_datetime + time_in_minutes.minutes
      end
      params.require(:walk_in).permit(:booking_date,:booking_time,:size,:phone,:party_name,:notes,:restaurant_id)
    end

    def set_walkin
      @walk_in = WalkIn.find(params[:id])
    end
end
