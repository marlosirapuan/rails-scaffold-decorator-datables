<%- module_namespacing do -%>
  <%- if parent_class_name.present? -%>
class <%= class_name %>Decorator < <%= parent_class_name %>
  <%- else -%>
class <%= class_name %>
  <%- end -%>
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def link_to
    h.link_to object.name, h.<%= class_name.downcase %>_path(object)
  end

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def actions
    links = []
    links <<
      h.link_to(
        fa_icon('eye'), h.<%= class_name.downcase %>_path(object),
        class: 'btn btn-sm btn-link'
      )
    links <<
      h.link_to(
        fa_icon('edit'), h.edit_<%= class_name.downcase %>_path(object),
        class: 'btn btn-sm btn-link'
      )
    links <<
      h.link_to(
        fa_icon('trash'), h.<%= class_name.downcase %>_path(object),
        class: 'btn btn-sm btn-link', data: { confirm: 'Confirma?', method: :delete }
      )

    helpers.content_tag :div, class: 'btn-group' do
      h.safe_join(links, '')
    end
  end
end
<% end -%>
