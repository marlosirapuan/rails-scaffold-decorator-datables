# frozen_string_literal: true

class <%= controller_class_name %>Controller < ApplicationController
  before_action :set_<%= singular_table_name %>, only: %i[show edit update destroy]

  # GET <%= route_url %>
  def index
    respond_to do |format|
      format.html
      format.json { render json: <%= class_name %>Datatable.new(params) }
    end
  end

  # GET <%= route_url %>/1
  def show
  end

  # GET <%= route_url %>/new
  def new
    @<%= singular_table_name %> = <%= class_name %>.new
  end

  # GET <%= route_url %>/1/edit
  def edit
  end

  # POST <%= route_url %>
  def create
    @<%= singular_table_name %> = <%= class_name %>.new(<%= singular_table_name %>_params)

    if @<%= singular_table_name %>.save
      redirect_to <%= singular_table_name %>_url(@<%= singular_table_name %>), notice: '<%= singular_table_name.humanize %> cadastrado com sucesso.'
    else
      render :new
    end
  end

  # PATCH/PUT <%= route_url %>/1
  def update
    if @<%= singular_table_name %>.update(<%= singular_table_name %>_params)
      redirect_to <%= singular_table_name %>_url(@<%= singular_table_name %>), notice: '<%= singular_table_name.humanize %> atualizado com sucesso.'
    else
      render :edit
    end
  end

  # DELETE <%= route_url %>/1
  def destroy
    if @<%= singular_table_name %>.destroy
      redirect_to <%= plural_table_name %>_url, notice: '<%= singular_table_name.humanize %> excluído com sucesso.'
    else
      redirect_to <%= singular_table_name %>_url(@<%= singular_table_name %>), alert: @<%= singular_table_name %>.errors.full_messages[0]
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_<%= singular_table_name %>
    @<%= singular_table_name %> = <%= class_name %>.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def <%= singular_table_name %>_params
    params.require(:<%= singular_table_name %>).permit(<%= attributes.map { |m| ":#{m.name}" }.join(", ") %>)
  end
end
