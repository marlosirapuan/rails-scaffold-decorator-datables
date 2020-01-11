class UserDatatable < AjaxDatatablesRails::ActiveRecord
  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      id:       { source: "User.id", cond: :eq },
      name:     { source: "User.name", cond: :like },
      email:    { source: "User.email", cond: :like },
      is_admin: { source: "User.is_admin", cond: :eq },
      status:   { source: "User.status", cond: :eq },
      actions:  { source: "User.id", orderable: false }
    }
  end

  def data
    records.map do |record|
      {
        id:       record.id,
        name:     record.decorate.link_to,
        email:    record.decorate.link_email,
        is_admin: record.decorate.level,
        status:   record.decorate.label_status,
        actions:  record.decorate.actions,
        DT_RowId: record.id
      }
    end
  end

  def additional_data
    records_filtered =
      search_value.present? ? @filters.count : User.count

    {
      recordsFiltered: records_filtered,
      recordsTotal: User.count
    }
  end

  # rubocop:disable Naming/AccessorMethodName
  def get_raw_records
    @filters = User.offset(params[:start]).limit(params[:length])
    return @filters if search_value.blank?

    @filters.search_for(search_value)
  end

  def search_value
    return nil if params.dig(:search, :value).blank?

    params.dig(:search, :value)
  end
end
