class CreatePlanService

  def call
    Plan.create({
      name: 'Basic',
      price: 3.99,
      interval: 'month',
      stripe_id: 'bronze',
      features: ['1 Project', '1 Page', '1 User', '1 Organization'].join("\n\n"),
      display_order: 1
    })

    Plan.create({
      name: 'Advanced',
      highlight: true, # This highlights the plan on the pricing page.
      price: 6.99,
      interval: 'month',
      stripe_id: 'silver',
      features: ['3 Projects', '3 Pages', '3 Users', '3 Organizations'].join("\n\n"),
      display_order: 2
    })
    
    Plan.create({
      name: 'Enterprise',
      price: 9.99, 
      interval: 'month',
      stripe_id: 'gold', 
      features: ['10 Projects', '10 Pages', '10 Users', '10 Organizations'].join("\n\n"), 
      display_order: 3
    })
  end
end