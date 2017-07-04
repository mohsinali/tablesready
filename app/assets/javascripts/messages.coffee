window.App ||= {}
class App.Messages extends App.Base

  beforeAction: (action) =>
    return


  afterAction: (action) =>
    return


  index: =>
    $bulkMessageForm = $("#bulk_message_form")
    $bulkMessageForm.submit (event) ->
      $($bulkMessageForm).validate
        focusInvalid: false
        errorClass: 'text-danger'
        validClass: 'valid'
        errorPlacement: (error, element) ->
          error.insertAfter $(element)

        rules:
          "message[template]":
            required: true
      if $($bulkMessageForm).valid()
        return true
      # Prevent the form from being submitted:
      false
    return


  show: =>
    return


  new: =>
    return


  edit: =>
    return
