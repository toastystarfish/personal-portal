
def create_simpsons_user args={}
  unless args[:first_name]
    raise ArgumentError, "No first name provided to create_simpsons_user"
  end

  args[:last_name]  ||= 'Simpson'
  args[:email]      ||= "#{args[:first_name].downcase}@springfield.com"
  args[:password]   ||= 'p@ssw0rd'
  User.create args
end

@homer  = create_simpsons_user first_name: 'Homer', roles_mask: User.roles[:owner] | User.roles[:admin]
@marge  = create_simpsons_user first_name: 'Marge', roles_mask: User.roles[:admin]
@lisa   = create_simpsons_user first_name: 'Lisa',  roles_mask: User.roles[:developer]
@bart   = create_simpsons_user first_name: 'Bart'
@maggie = create_simpsons_user first_name: 'Maggie'
@apu    = create_simpsons_user first_name: 'Apu', last_name: 'Nahasapeemapetilon'
@nelson = create_simpsons_user first_name: 'Nelson', last_name: 'Muntz'
@troy   = create_simpsons_user first_name: 'Troy', last_name: 'McClure'
@lenny  = create_simpsons_user first_name: 'Lenny', last_name: 'Leonard'
@carl   = create_simpsons_user first_name: 'Carl', last_name: 'Carlson'
@frink  = create_simpsons_user first_name: 'John', last_name: 'Frink',
          roles_mask: User.roles[:developer]

@ned = create_simpsons_user first_name: "Ned", last_name: "Flanders",
       email: "ned@flanders.com", roles_mask: User.roles[:developer]

#Lisa was invited by homer and accepted it
@lisas_accepted_invitation = Invitation.create({
  email: "lisa@springfield.com",
  invited_by_id: @homer.id,
  created_at: DateTime.now.to_s,
  token: "ababababababab"
})

@lisas_accepted_invitation.accept

@burns_invitation = Invitation.create({
  email: "burns@springfield.com",
  invited_by_id: @homer.id,
  created_at: DateTime.now.to_s,
  token: "xxxxxxxxxxxxx"
})
