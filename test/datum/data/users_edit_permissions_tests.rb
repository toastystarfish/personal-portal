UsersEditPermissionsTest = Datum.new(:logged_in_user, :target_user,
  :attributes_hash, :expect_success, :msg)

#Admin editing admin
UsersEditPermissionsTest.new :@marge, :@homer,
{ last_name: 'Homerer', roles_mask: :admin }, true,
"admin should be able to edit any user"

#Admin editing self
UsersEditPermissionsTest.new :@marge, :@marge,
{first_name: "Margine", last_name: 'Homerer' }, true,
"admin should be able to edit themselves"

UsersEditPermissionsTest.new :@marge, :@bart,
{password: 'I will not do that thing',
  password_confirmation: 'I will not do that thing'}, true,
"admin should be able to change password for anyone"

#Non admin editing self
UsersEditPermissionsTest.new :@bart, :@bart,
{ password: 'no more detention',
  password_confirmation: 'no more detention'}, true,
"non admins should be able to edit themselves"

#Non admin editing others
UsersEditPermissionsTest.new :@bart, :@homer,
{last_name: "Daddo"}, false,
"non admins shouldn't be able to edit other users"

UsersEditPermissionsTest.new :@lisa, :@homer,
{last_name: "Dad"}, false,
"interns should not be able to edit other interns"
