require 'test_helper'

class InvitationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    process_scenario :simpsons
  end

  test "should invite new user" do
    sign_in @homer
    send_mail @homer, true
  end

  test "should not invite new user" do
    sign_in @bart
    send_mail @bart, false
  end

  test "should get new" do
    sign_in @homer
    get new_invitation_url
    assert_response(:success, "Could not get invitation/new")
  end

  private

  # TODO: If we arent sending a mail note that we arent doing it and we dont care (locally)
  def send_mail person, should_send
    post invitations_url, params: {invitation: { email: "test_mail@lc41.com",
                                    invited_by_id: person.id}}
    ##This might cause problems, might want to adjust what invite we grab
    invite = Invitation.last
    if should_send
      should_send_mail invite
    else
      # NOTE: ZH: don't have invites in the database, at this point unless loaded
      # by the scenario so the check doesn't make sense
      # assert invite.invited_by_id != person.id?, "Invite created by non admin account"
      assert_redirected_to root_path, "Bad redirect after failed invite"
    end
  end

  def should_send_mail invite
    inviter = User.find(invite.invited_by_id)

    from = "#{inviter.name} <#{inviter.email}>"
    subject = "Invitation To #{Rails.application.class.parent_name}"

    UserMailer::manual_invitation_instructions(invite.email,
      from, subject)
    mail = ActionMailer::Base.deliveries.last
    assert_not_nil mail, 'No email was created' # TODO: is it our mail? some other mail? check your privledge!!!
  end
end
