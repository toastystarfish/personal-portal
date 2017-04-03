UsersShowPermissionsTest = Datum.new(:user_to_log_in, :target_user,
  :expect_success, :msg)

#Admin looking at other admin's show page
UsersShowPermissionsTest.new :@marge, :@homer, true,
"admin should be able to access other admins show page"

#Admin looking at other non admin's show page
UsersShowPermissionsTest.new :@marge, :@bart, true,
"admin should be able to access other users show page"

#Non admin looking at their own show page
UsersShowPermissionsTest.new :@lisa, :@lisa, true,
"users should be able access their own show page"

#Non admin looking at other non admin's show page
UsersShowPermissionsTest.new :@lisa, :@bart, false,
"users should not be able access other user's show page"

#Non admin looking at admin's show page
UsersShowPermissionsTest.new :@lisa, :@bart, false,
"users should not be able access other user's show page"
