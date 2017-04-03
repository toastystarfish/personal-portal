
def create_user args={}
  unless args[:first_name]
    raise ArgumentError, "No first name provided to create_user"
  end

  args[:last_name] ||= 'Simpson'
  args[:email]     ||= "#{args[:first_name].downcase}@springfield.com"
  args[:password]  ||= 'p@ssw0rd'
  User.create args
end

@homer  = create_user first_name: 'Homer',  roles_mask: User.roles[:owner]
@marge  = create_user first_name: 'Marge',  roles_mask: User.roles[:admin]
@lisa   = create_user first_name: 'Lisa',   roles_mask: User.roles[:developer]
@bart   = create_user first_name: 'Bart'
@maggie = create_user first_name: 'Maggie'

@ned = create_user first_name: "Ned", last_name: "Flanders", email: "ned@flanders.com", roles_mask: User.roles[:developer]

#Lisa was invited by homer and accepted it
@lisas_accepted_invitation = Invitation.create({
  email: "marge@tyemill.com",
  invited_by_id: @homer.id,
  created_at: DateTime.now.to_s,
  token: "ababababababab"
})

@lisas_accepted_invitation.accept

@burns_invitation = Invitation.create({
  email: "burns@tyemill.com",
  invited_by_id: @homer.id,
  created_at: DateTime.now.to_s,
  token: "xxxxxxxxxxxxx"
})
