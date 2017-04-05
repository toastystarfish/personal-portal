class UserMailer < ApplicationMailer
  # This is a hash of default values for any email you send from this mailer.
  # In this case we are setting :from header to a value for all messsages in this
  #     class. This can be overriden per email basis

  default from: (ENV['INVITE_FROM'] || "noreply@#{app_name.downcase}.com")

  SUBJECT = "You've been invited to join #{app_name}"

  # Creates the message to be delivered by email
  def invite_new_user(invitation)
    @invitation = invitation
    # The actual email message, we are passing the :to and :subject headers
    mail(to: invitation.email, subject: SUBJECT, &:html)
  end

  # To send invitations in TESTS
  def manual_invitation_instructions(to, from, subject)
    invoke_mail to, from, subject, false
  end

  private

  def app_name
    Rails.application.class.parent_name
  end

  # helper to send invitation in tests
  def invoke_mail(to, from, subject, do_format = true)
    mail(to: to, from: from, subject: subject) do |format|
      format.html if do_format
    end
  end
end
