class UsersController < ResourcesController
  resource_model User

  before_action :authenticate_user!, except: [:create]
  before_action :set_user, only: [:update]

  def new
    super
    @user.email = invitation.email unless invitation.blank?
    authorize @user
    sign_out
  end

  def create
    @user = User.new user_params.except(:roles_mask)
    @user.invitation&.assign_attributes token: params[:token]
    authorize @user

    respond_to do |format|
      if @user.save
        @user.invitation.accept
        # dont require sign in if user created from token
        bypass_sign_in @user if current_user.blank?
        format.html { redirect_to root_path, notice: "Account successfully created."}
      else
        format.html {render action: 'new'}
      end
    end
  end

  def update
    @user.assign_attributes user_params_for_update
    authorize @user

    respond_to do |format|
      if @user.save
        # if the password is present (we're updating it) and current_user is
        # the user being updated, we need to sign back in for ourselves
        bypass_sign_in @user if updating_self? && updating_password?
        format.html { redirect_to @user, notice: "User updated."}
      else
        format.html { render action: 'edit'}
      end
    end
  end

  private

  def set_user
    @user = UsersQuery.find params[:id]
  end

  def invitation
    @invitation ||= InvitationsQuery.first_with_token params[:token]
  end

  def authenticate_user!
    super unless invitation.present? && invitation.accepted_at.nil?
  end

  def updating_self?
    current_user.id == @user.id
  end

  def updating_password?
    user_params[:password].present?
  end

  def user_params_for_update
    user_params.tap do |par|
      # unless you are changing your password to something new we dont want to
      # update this attribute
      unless updating_password?
        par.delete :password
        par.delete :password_confirmation
      end
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password,
      :password_confirmation)
  end
end
