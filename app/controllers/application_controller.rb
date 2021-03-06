class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  # this is a global catch for pundit failed
  # needed for invitations
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  PUNDIT_ERROR = 'You are not authorized to perform this action'

  protected

  def pundit_msg
    PUNDIT_ERROR
  end

  # Default Error Message: see PUNDIT_ERROR
  # if you need to customize that - override the pundit_message method in the
  # child controller
  def user_not_authorized exception
    flash[:alert] = pundit_msg
    respond_to do |format|
      format.html { redirect_to request.referrer || root_path }
    end
  end
end
