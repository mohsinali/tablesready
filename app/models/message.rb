require 'clickatell_box'
class Message < ApplicationRecord
  belongs_to :restaurant
  enum message_type: [:text_ready,:marketing]

  scope :by_restaurant, -> (restaurant) {where(restaurant: restaurant)}


  def self.send_sms recipents,content,restaurant
    sent_count = 0
    message_sender = ClickatellBox.new
    recipents.each_slice(100).to_a.each do |phones|
      response = message_sender.send_sms(phones,content)
      unless response[:error]
        parsed_response = JSON.parse(response[:data])
        # log messages
        parsed_response['messages'].each do |message_json|
          unless message_json['error']
            sent_count +=1
            Message.create(message_type: :marketing,restaurant_id: restaurant.id,template: content,api_message_id: message_json['apiMessageId'],recipent: message_json['to'])
          end
        end
      end
    end
    if sent_count == 0
      response = {error: true,message: "There is problem to connect message sending server. Please try again."}
    else
      response = {error: false,message: "Message sent successfully to #{sent_count} customers."}
    end
    response
  end

end
