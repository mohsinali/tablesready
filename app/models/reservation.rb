require "csv"
class Reservation < Booking

  def self.import restaurant, csv_path
    @reservations = []
    begin
      CSV.foreach(csv_path) do |row|
        puts "row: #{row}"
        @reservations << Reservation.new(booking_date: row[0],booking_time: row[0],party_name: row[1],size: row[2],phone: row[3],notes: row[4],restaurant_id: restaurant.id)
      end
      response = {error: false,message: "CSV file is imported successfully!"}
    rescue Exception => e
      response = {error: true,message: e.message}
    end

    @reservations.map(&:save) unless response[:error]
    return response
  end
end
