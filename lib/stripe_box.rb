module StripeBox
  def create_stripe_customer(token, email)
    begin
      Stripe::Customer.create(
        :description => "Customer for #{email}",
        :email => email,
        :source => token
      )
    rescue Exception => e
      puts "=============== EXCEPTION - StripeBox::create_stripe_customer() " + e.message
    end
  end

  def get_customer customer_id
    Stripe::Customer.retrieve(customer_id)
  end

  def create_card customer_id, token
    begin
      customer = Stripe::Customer.retrieve(customer_id)
      card = customer.sources.create(:card => token)
      response = { error: false,  card: card }
    rescue Exception => e
      puts "=============== EXCEPTION - StripeBox::create_card() " + e.message
      response = { error: true, message: e.message }
    end

    return response
  end

  ########################################################
  ### Amount in cents
  def create_invoice_item customer, amount
    begin
      Stripe::InvoiceItem.create(
        :customer => customer.id,
        :amount => amount,
        :currency => "GBP",
        :description => "One-time setup fee"
      )
    rescue Exception => e
      puts "=============== EXCEPTION - StripeBox::create_invoice_item() " + e.message
    end
  end

  def create_subscription customer, plan_id, trial_availed
    trial = trial_availed ? "now" : (DateTime.now + ENV["TRIAL_PERIOD_DAYS"].to_i.days).to_i
    begin
      @sub = Stripe::Subscription.create(
        :customer => customer,
        :plan => plan_id,
        :trial_end => trial
      )
      response = { error: false,  sub: @sub }
    rescue Exception => e
      puts "=========== Exception ==========="
      puts e.message
      
      response = { error: true,  message: e.message }
    end
    
    return response
  end

  def update_subscription customer, subscription_id, plan_id, trial_availed
    
    begin
      subscription = Stripe::Subscription.retrieve(subscription_id)
      subscription.plan = plan_id
      subscription.prorate = true
      subscription.trial_end = "now" if trial_availed
      subscription.save

      response = { error: false, sub: subscription }
    rescue Exception => e
      puts "=========== Exception ==========="
      puts e.message
      
      response = { error: true,  message: e.message }
    end
  end

  def cancel_subscription subscription_id
    begin
      subscription = Stripe::Subscription.retrieve(subscription_id)
      subscription.delete

      response = { error: false, sub: subscription }
    rescue Exception => e
      puts "=========== Exception ==========="
      puts e.message
      
      response = { error: true,  message: e.message }
    end
  end

  

  def get_card_by_id customer_id, card_id
    begin
      customer = Stripe::Customer.retrieve(customer_id)
      card = customer.sources.retrieve(card_id)      

      response = { error: false, card: card }
    rescue Exception => e
      puts "=============== EXCEPTION - StripeBox::get_card_by_id() " + e.message
      response = { error: true, message: e.message }
    end

    return response
  end

  def get_card_by_token token
    begin
      card = Stripe::Token.retrieve(token)
      response = { error: false, card: card[:card] }

    rescue Exception => e
      puts "=============== EXCEPTION - StripeBox::default_source() " + e.message
      response = { error: true, message: e.message }
    end
    return response
  end

end