class ReportsController < ApplicationController
  before_action :set_report_dates
  def index
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
