window.App ||= {}
class App.Messages extends App.Base

  beforeAction: (action) =>
    return


  afterAction: (action) =>
    return


  index: =>
    templates = []
    $(".sortable").sortable
      scroll: false
      update: (event, ui) ->
        updateTemplatesOrder()

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

    updateTemplatesOrder = ->
      $(".sortable .message_template").each (index,element) ->
        templates.push({index: index,template_id: $(element).attr("template_id")})
      $.post "/message_templates/update_order",{'templates': templates}
      return

    return


  show: =>
    return


  new: =>
    return


  edit: =>
    return
