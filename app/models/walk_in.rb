class WalkIn < Booking
  # set checkin to true
  after_create :set_checkin
  after_save :set_noshow_job

  
  ##########################################
  ## Send message to customer, and schedule
  ## next message, if next template exists
  ## @params: message_template
  ##########################################
  def send_message message_template
    next_template = MessageTemplate.next_template(message_template)
    recipents = [self.phone]
    content = message_template.template
    response = Message.send_sms(recipents,content,self.restaurant,'text_ready')
    if next_template.present? and !response[:error]
      # schedule next message, if next template exists
      next_scheduled_time = Time.now + next_template.next_delay.to_i.minutes
      self.delay(run_at: next_scheduled_time).send_message(next_template)
    end
    response
  end
end
