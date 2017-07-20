class ReportsController < ApplicationController
  before_action :set_report_dates
  def index
    start_time = @from.beginning_of_day
    end_time = @to.end_of_day
    @customers_count = my_restaurant.customers.where(created_at: [start_time .. end_time]).count
    @bookings = my_restaurant.bookings.where(created_at: [start_time .. end_time]).select("avg(wait_in_minutes) as avg_time,max(wait_in_minutes) as max_time")
    if @bookings.any?
      @longest_wait_time = @bookings[0].try(:max_time).to_i
      @avg_wait_time = @bookings[0].try(:avg_time).to_i
    else
      @longest_wait_time = 0
      @avg_wait_time = 0
    end
  end


  private
    def set_report_dates
      @from = Date.today - 7.days
      @to = Date.today
      if params[:reports]
        from_date = params[:reports][:from].to_s.split("/")
        to_date = params[:reports][:to].to_s.split("/")
        @from = "#{from_date[2]}-#{from_date[0]}-#{from_date[1]}".to_date
        @to = "#{to_date[2]}-#{to_date[0]}-#{to_date[1]}".to_date
      end
    end
end
