ActiveAdmin.register_page "Reports" do
  
  content do
    render partial: 'reports'
  end

end

ActiveAdmin.register_page "Reports" do

  sidebar :filters, partial: 'filters'

  content title:  "User Reports with total no. of subscribers" do
    if params[:reports]
      @from = params[:reports][:from]
      @to = params[:reports][:to]
    else
      @from  = Date.today - 1.month
      @to = Date.today
    end
    @from = @from.to_date.beginning_of_day
    @to = @to.to_date.end_of_day
    
    columns do
      column do
        panel "Subscribers" do
          table do
            thead do
              th "Name"
              th "Email"
              th "No. of Subscribers"
              th "No. of Wait List SMS Sent"
              th "No. of Marketing SMS Sent"
            end

            tbody do
              User.all.each do |user|
                restaurant = user.restaurant
                tr do
                  td user.name
                  td user.email
                  td restaurant.customers.count
                  td restaurant.messages.text_ready.where(created_at: [@from .. @to]).count
                  td restaurant.messages.marketing.where(created_at: [@from .. @to]).count
                end if restaurant
              end
            end
          end
        end
      end
    end
  end
end

