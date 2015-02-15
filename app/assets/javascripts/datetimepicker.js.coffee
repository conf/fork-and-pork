reinitializeDatetimePicker = ->
  $('[data-format=datetime] .form_datetime').datetimepicker(format: 'ddd, D MMM YYYY HH:mm')
  $('[data-format=date] .form_datetime').datetimepicker(format: 'ddd, D MMM YYYY')
  $('[data-format=time] .form_datetime').datetimepicker(format: 'HH:mm')

  $('.date_time_picker:input').click ->
    $(this).parent().data('DateTimePicker').show();

  $('[data-link-to] .form_datetime').on('dp.change', (e) ->
    parent = $(this).parent()
    linkedPickerSelector = parent.data('link-to')

    linkedPicker = $(linkedPickerSelector).data('DateTimePicker')
    linkedPicker.minDate(e.date) if $(this).parent().data('link-min')
    linkedPicker.maxDate(e.date) if $(this).parent().data('link-max')
  )

$ ->
  reinitializeDatetimePicker()

$(document).bind('ajaxComplete', ->
  reinitializeDatetimePicker()
)
