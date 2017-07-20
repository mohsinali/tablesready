window.App ||= {}
class App.Reports extends App.Base

  beforeAction: (action) =>
    return


  afterAction: (action) =>
    return


  index: =>
    App.applyDatePicker($("#reports_from"),true)
    App.applyDatePicker($("#reports_to"),true)

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


    generateGraph = (json_data)->
      barOptions = 
        series: lines:
          show: true
          lineWidth: 2
          fill: true
          fillColor: colors: [
            { opacity: 0.0 }
            { opacity: 0.0 }
          ]
        xaxis:
          mode: 'time'
          tickDecimals: 0
        colors: [ '#1ab394',"#ddd" ]
        grid:
          color: '#999999'
          hoverable: true
          clickable: true
          tickColor: '#D4D4D4'
          borderWidth: 0
        legend: show: false
        tooltip: true
        tooltipOpts: content: "Time: %x, bookings: %y"
      
      barData = []
      hour = 0
      while hour < 24
        barData.push([Date.UTC(2017,7,20,hour,0),json_data[hour]])
        hour +=1
      $.plot $('#flot-line-chart'), [ barData ], barOptions
      return
    generateGraph(gon.hourly_bookings_json)
    return


  show: =>
    return


  new: =>
    return


  edit: =>
    return