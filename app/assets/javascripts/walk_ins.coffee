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
        $("#walk_in_booking_time").val(new Date())
        return true
      # Prevent the form from being submitted:
      false


    calculateTime = (minutes) ->
      currentTime = new Date()

    return


  show: =>
    return


  new: =>
    return


  edit: =>
    return
