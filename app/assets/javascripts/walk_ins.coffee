window.App ||= {}
class App.WalkIns extends App.Base

  beforeAction: (action) =>
    return


  afterAction: (action) =>
    return


  index: =>
    
    $walkinForm = $("#walk_in_form")

    $(document).on "click",".reset_form_btn", (event) ->
      event.preventDefault()
      App.resetForm($walkinForm[0])
      
    $walkinForm.submit (event) ->
      $($walkinForm).validate
        focusInvalid: false
        errorClass: 'text-danger'
        validClass: 'valid'
        invalidHandler: (form, validator) ->
          return  unless validator.numberOfInvalids()
          $("html, body").animate
            scrollTop: $(validator.errorList[0].element).offset().top
          , 200

        errorPlacement: (error, element) ->
          error.insertAfter $(element)

        rules:
          "time_in_minutes":
            required: true
          "walk_in[party_name]":
            required: true
          "walk_in[size]":
            required: true
            number: true
          "walk_in[phone]":
            required: true
            phoneCheck: true
          "walk_in[notes]":
            required: true
      if $($walkinForm).valid()
        minutes = parseInt($("#time_in_minutes").val())
        time = calculateTime(minutes)
        $("#walk_in_booking_time").val(time)
        return true
      # Prevent the form from being submitted:
      false


    # current time plus minutes
    calculateTime = (minutes) ->
      currentTime = new Date()
      # get time in milliseconds
      currentTime = (currentTime.getTime() + minutes*60*1000)
      bookingTime = new Date(currentTime)
      bookingTime = "#{bookingTime.getFullYear()}-#{bookingTime.getMonth()}-#{bookingTime.getDate()} #{bookingTime.getHours()}:#{bookingTime.getMinutes()}"
      return bookingTime
    return


  show: =>
    return


  new: =>
    return


  edit: =>
    return

  # update form validation
  updateWalkinFormValidator: ->
    $updateWalkinForm = $("#walk_in_update_form")
    $updateWalkinForm.submit (event) ->
      $($updateWalkinForm).validate
        focusInvalid: false
        errorClass: 'text-danger'
        validClass: 'valid'
        errorPlacement: (error, element) ->
          error.insertAfter $(element)

        rules:
          "walk_in[party_name]":
            required: true
          "walk_in[size]":
            required: true
            number: true
          "walk_in[phone]":
            required: true
            phoneCheck: true
          "walk_in[notes]":
            required: true
      if $($updateWalkinForm).valid()
        return true
      # Prevent the form from being submitted:
      false
    return
