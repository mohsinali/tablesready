class WalkInsController < ApplicationController

  before_action :set_walkin,only: [:edit,:update,:destroy,:change_status]

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

  def change_status
    @walk_in.send("#{params[:status]}!")
    respond_to do |format|
      format.js {render layout: false}
    end
  end

  def destroy
    @walk_in.cancelled!
    @walk_in.destroy
    respond_to do |format|
      format.js {render layout: false}
    end
  end

  private

    def walk_in_params
      params.require(:walk_in).permit(:booking_date,:booking_time,:size,:phone,:party_name,:notes,:restaurant_id)
    end

    def set_walkin
      @walk_in = WalkIn.find(params[:id])
    end
end