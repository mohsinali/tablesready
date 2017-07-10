##########################################################
## All the regular experession validators will be
## defined in this method: FormValidators
## Scope: Globally used throughout the jobseeker theme
## Author: Sarwan Kumar
App.formValidators = ->
  $.validator.addMethod 'phoneCheck', ((phone_number, element) ->
    this.optional(element) or phone_number.match /^[+]{0,1}(?:[0-9]●?){6,14}[0-9]$/
  ), 'Please enter a valid phone number'

############# END OF Method: FormValidators ##############
##########################################################

#### signin form validations ####
App.signinFormValidator = ->
  $("#signin_form").validate
    errorClass: 'text-danger'
    validClass: 'valid'
    errorPlacement: (error, element) ->
      error.insertAfter $(element)

    rules:
      "user[email]":
        required: true
        email: true
      "user[password]":
        required: true
    messages:
      "user[email]":
        required: "Email is required."
        email: "Please enter a valid email address."

      "user[password]":
        required: "Password is required."

#### signup form validations ####
App.signUpFormValidator = ->
  $("#signup_form").validate
    errorClass: 'text-danger'
    validClass: 'valid'
    errorPlacement: (error, element) ->
      error.insertAfter $(element)

    rules:
      "restaurant_name":
        required: true
      "user[name]":
        required: true
      "user[email]":
        required: true
        email: true
      "user[phone]":
        required: true
        phoneCheck: true
      "user[password]":
        minlength: 8
        required: true

      "user[password_confirmation]":
        required: true
        minlength: 8
        equalTo: "#user_password_confirmation"
    messages:
      "restaurant_name":
        required: "Restaurant Name is required."
      "user[name]":
        required: "Name is required."
      "user[email]":
        required: "Email is required."
        email: "Please enter a valid email address."

      "user[password]":
        required: "Password is required."

      "user[password_confirmation]":
        required: "Confirm password is required."
        equalTo: "Password and Confirm Password does not match."


#### new password form validations ####
App.newPasswordFormValidator = ->
  $("#new_password_form").validate
    errorClass: 'text-danger'
    validClass: 'valid'
    errorPlacement: (error, element) ->
      error.insertAfter $(element)

    rules:
      "user[email]":
        required: true
        email: true
    messages:
      "user[email]":
        required: "Email is required."
        email: "Please enter a valid email address."

#### edit password form validations ####
App.editPasswordFormValidator = ->
  $("#edit_password_form").validate
    errorClass: 'text-danger'
    validClass: 'valid'
    errorPlacement: (error, element) ->
      error.insertAfter $(element)

    rules:
      "user[password]":
        minlength: 8
        required: true

      "user[password_confirmation]":
        required: true
        minlength: 8
        equalTo: "#user_password_confirmation"
    messages:
      "user[password]":
        required: "Password is required."
      "user[password_confirmation]":
        required: "Confirm password is required."
        equalTo: "Password and Confirm Password does not match."

# reset form hanlder
App.resetForm = ($element)->
  $element.reset()


App.currentTimeZone = ->
  try
    timezone = Intl.DateTimeFormat().resolved.timeZone
  catch e
    timezone = "UTC"

  return timezone

App.setCurrentTimeZone = ->
  timezone = App.currentTimeZone()
  if $("#current_time_zone").length > 0
    $("#current_time_zone").val(timezone)
  else
    console.log("no timezone field defined!")

App.applyDatePicker = (element)->
  $(element).datepicker
    dateFormat: "mm/dd/yy"
    altFormat: "mm/dd/yy"
    minDate: new Date()

App.applyTimePicker = (element) ->
  $(element).datetimepicker
    datepicker:false
    format:'H:i'
    step: 15
