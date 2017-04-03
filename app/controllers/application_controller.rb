class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :configure_devise_params, if: :devise_controller?

  # this is a global catch for pundit failed
  # needed for invitations
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  PUNDIT_ERROR = 'You are not authorized to perform this action'

  protected

  def pundit_msg
    PUNDIT_ERROR
  end

  def configure_devise_params
    devise_parameter_sanitizer.permit(:sign_up) do |params|
      params.permit :first_name, :last_name, :email, :password,
                    :password_confirmation
    end
  end

  # Default Error Message: see PUNDIT_ERROR
  # if you need to customize that - override the pundit_message method in the
  # child controller
  def user_not_authorized exception
    flash[:alert] = pundit_msg
    respond_to do |format|
      format.html { redirect_to(request.referrer || root_path) }
    end
  end
end
