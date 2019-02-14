class UsersController < ResourcesController
  resource_model User

  before_action :authenticate_user!, except: [:create]
  # before_action :set_user, only: [:update]

  def new
    sign_out
    @user = User.new
    @user.email = invitation.email unless invitation.blank?
    authorize @user
    @token = params[:token]
  end

  def create
    @user = User.new(permitted_attributes(User))
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
    @user.assign_attributes(permitted_attributes(@user))
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
    params[:user][:password].present?
  end
end
