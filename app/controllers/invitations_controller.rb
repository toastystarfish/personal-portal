class InvitationsController < ApplicationController
  def new
    @invitation = Invitation.new
    @invitation.invited_by_id = current_user.id
    authorize @invitation
  end

  # creates the invitation and delivers it to the user
  def create
    @invitation = Invitation.new(permitted_attributes(Invitation))

    authorize @invitation
    # remove old unaccepted invitations
    InvitationsQuery.delete_with_email @invitation.email

    @invitation.created_at = Time.now
    @invitation.token = Invitation.generate_token
    respond_to do |format|
      if @invitation.save
        # The invitation has successfully saved. We can deliever the
        # mails and the redirect to wherever we are going to redirect to.
        UserMailer.invite_new_user(@invitation).deliver_now
        format.html do
          redirect_to users_path,
                      notice: 'Invitation was successfully created.'
        end
      else
        format.html { render action: 'new' }
      end
    end
  end

  private

  # def invitation_params
  #   params.require(:invitation).permit(:invited_by_id, :sent_at,
  #                                      :accepted_at, :token, :email)
  # end
end
