class DateTimePickerInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    template.content_tag(:div, class: 'input-group date form_datetime') do
      template.concat @builder.text_field(attribute_name, merge_wrapper_options(input_html_options, wrapper_options))
      template.concat span_table
    end
  end

  def input_html_options
    value = object.try(:[], attribute_name)
    value ? super.merge(value: l(value)) : super
  end

  def span_table
    template.content_tag(:span, class: 'input-group-addon') do
      template.concat icon_table
    end
  end

  def icon_table
    "<span class='glyphicon glyphicon-calendar'></span>".html_safe
  end

end
