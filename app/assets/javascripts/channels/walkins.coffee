App.bookings = App.cable.subscriptions.create('WalkinsChannel',
  received: (data) ->
    id = data.booking.id
    $("#booking_#{id}").remove()
  renderMessage: (data) ->
    console.log("in renderMessage: #{data}")
)

App.message_sequence = App.cable.subscriptions.create('MessageSequenceChannel',
  received: (data) ->
    id = data.booking_id
    $("#booking_#{id}").replaceWith(data.html_template)
  renderMessage: (data) ->
    console.log("in renderMessage: #{data}")
)