# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  def index
    respond_to do |format|
      format.html
      format.json { render json: UserDatatable.new(params) }
    end
  end

  # GET /users/1
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create
    @user = user.new(user_params)

    if @user.save
      redirect_to sistema_users_url, notice: 'Usuário cadastrado com sucesso.'
    else
      render :new
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to user_url(@user), notice: 'Usuário atualizado com sucesso.'
    else
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    if @user.destroy
      redirect_to users_url, notice: 'Usuário excluído com sucesso.'
    else
      redirect_to user_url(@user), alert: @user.errors.full_messages[0]
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find_by(id: params[:id])&.decorate

    redirect_to root_url, alert: 'Usuário não encontrado' if @user.blank?
  end

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.require(:user).permit(:name, :email, :is_admin, :status)
  end
end
