class ApplicationDecorator < Draper::Decorator
  # Define methods for all decorated objects.
  # Helpers are accessed through `helpers` (aka `h`). For example:
  #
  #   def percent_amount
  #     h.number_to_percentage object.amount, precision: 2
  #   end

  def fa_icon(icon_name)
    return '' if icon_name.blank?

    helpers.content_tag(:span, nil, class: "fa fa-#{icon_name}")
  end
end
