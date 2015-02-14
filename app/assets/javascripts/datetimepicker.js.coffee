reinitializeDatetimePicker = ->
  $('.form_datetime').datetimepicker(
    format: 'ddd, D MMM YYYY HH:mm',
  )

$ ->
  reinitializeDatetimePicker()

$(document).bind('ajaxComplete', ->
  reinitializeDatetimePicker()
)
