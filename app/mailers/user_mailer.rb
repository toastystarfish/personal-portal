class UserMailer < ApplicationMailer
  # This is a hash of default values for any email you send from this mailer.
  # In this case we are setting :from header to a value for all messsages in this
  #     class. This can be overriden per email basis

  APPNAME = Rails.application.class.parent_name
  default from: (ENV['INVITE_FROM'] || "noreply@#{APPNAME.downcase}.com")

  SUBJECT = "You've been invited to join #{APPNAME}"

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

  # helper to send invitation in tests
  def invoke_mail(to, from, subject, do_format = true)
    mail(to: to, from: from, subject: subject) do |format|
      format.html if do_format
    end
  end
end
