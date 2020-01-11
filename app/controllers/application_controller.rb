class ApplicationController < ActionController::Base
  include TurbolinksCacheControl

  layout :layout_by_resource

  before_action :authenticate_user!
  before_action :set_paper_trail_whodunnit
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method def title(value = nil)
    if value
      @title = value
    else
      @title
    end
  end

  protected

  def current_user
    super&.decorate
  end

  private

  def layout_by_resource
    if devise_controller? && not_edit_user_area?
      "devise"
    else
      "application"
    end
  end

  def configure_permitted_parameters
    update_attrs = [:password, :password_confirmation, :current_password]
    devise_parameter_sanitizer.permit :account_update, keys: update_attrs
  end

  def not_edit_user_area?
    resource_name == :user && action_name != 'edit'
  end
end
