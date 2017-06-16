App.bookings = App.cable.subscriptions.create('WalkinsChannel',
  received: (data) ->
    id = data.booking.id
    console.log("In booking: id: #{id}")
    $("#booking_#{id}").remove()
  renderMessage: (data) ->
    console.log("in renderMessage: #{data}")
)