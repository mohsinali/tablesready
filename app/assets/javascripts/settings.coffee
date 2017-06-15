window.App ||= {}
class App.Settings extends App.Base

  beforeAction: (action) =>
    return


  afterAction: (action) =>
    return


  index: =>
    return


  show: =>
    return


  new: =>
    return


  edit: =>
    return

  profile: =>
    $profileForm = $("#profile_setting_form")
    $profileForm.submit (event) ->
      $($profileForm).validate
        focusInvalid: false
        errorClass: 'text-danger'
        validClass: 'valid'
        errorPlacement: (error, element) ->
          error.insertAfter $(element)

        rules:
          "user[name]":
            required: true
          "user[phone]":
            required: true
            phoneCheck: true
          "user[time_zone]":
            required: true
          "user[no_show_threshold]":
            required: true
            number: true
      if $($profileForm).valid()
        return true
      # Prevent the form from being submitted:
      false
    return
