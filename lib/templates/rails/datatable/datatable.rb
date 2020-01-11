class <%= datatable_name %> < AjaxDatatablesRails::ActiveRecord
  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      # Same fields from table columns in index.html.slim file,
      id: { source: "<%= name.humanize %>.id", cond: :eq },
      # field1: { source: "<%= name.humanize %>.field1", cond: :like },
      # field2: { source: "<%= name.humanize %>.field2", cond: :like },
      actions: { source: "<%= name.humanize %>.id", orderable: false }
    }
  end

  def data
    records.map do |record|
      {
        # Same fields from table columns in index.html.slim file,
        # except 'DT_RowId', used by datatable.js as row identifier
        id: record.id,
        # field1: record.field1,
        # field2: record.field2,
        actions: record.decorate.actions,
        DT_RowId: record.id
      }
    end
  end

  def additional_data
    records_filtered =
      search_value.present? ? @filters.count : <%= name.humanize %>.count

    {
      recordsFiltered: records_filtered,
      recordsTotal: <%= name.humanize %>.count
    }
  end

  def get_raw_records
    @filters = <%= name.humanize %>.offset(params[:start]).limit(params[:length])
    return @filters if search_value.blank?

    @filters.search_for(search_value)
  end

  def search_value
    return nil if params.dig(:search, :value).blank?

    params.dig(:search, :value)
  end
end
