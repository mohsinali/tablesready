window.App ||= {}
class App.Reports extends App.Base

  beforeAction: (action) =>
    return


  afterAction: (action) =>
    return


  index: =>
    App.applyDatePicker($("#reports_from"),true)
    App.applyDatePicker($("#reports_to"))

    $reportsForm = $("#reports_form")
    $reportsForm.submit (event) ->
      $($reportsForm).validate
        focusInvalid: false
        errorClass: 'invalid'
        validClass: 'valid'
        invalidHandler: (form, validator) ->
          return  unless validator.numberOfInvalids()
          $("html, body").animate
            scrollTop: $(validator.errorList[0].element).offset().top
          , 200

        errorPlacement: (error, element) ->
          error.insertAfter $(element)

        rules:
          "reports[from]":
            required: true
          "reports[to]":
            required: true
            # validDateCheck: true
      if $($reportsForm).valid()
        $(".submit_btn").attr("disabled",true)
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
