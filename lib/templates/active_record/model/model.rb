# frozen_string_literal: true
class <%= class_name %> < <%= parent_class_name.classify %>
  include PgSearch::Model

  pg_search_scope :search_for,
                  against: [<%= attributes.reject { |attr| attr.reference? }.map { |attr| ":#{attr.name}" }.join(', ') %>],
                  ignoring: :accents,
                  using: {
                    tsearch: { any_word: true }
                  }

  has_paper_trail

<% attributes.select { |attr| attr.reference? }.each do |attribute| -%>
  belongs_to :<%= attribute.name %>

<% end -%>
  def to_s
    <%= attributes.first.name %>
  end
end
