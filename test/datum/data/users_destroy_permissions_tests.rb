UsersDestroyPermissionsTest = Datum.new(:user_to_log_in, :target_user, :difference)

UsersDestroyPermissionsTest.new(:@homer, :@marge, -1)
UsersDestroyPermissionsTest.new(:@homer, :@bart, -1)
UsersDestroyPermissionsTest.new(:@marge, :@bart, -1)
UsersDestroyPermissionsTest.new(:@homer, :@homer, 0)
UsersDestroyPermissionsTest.new(:@bart, :@homer, 0)
UsersDestroyPermissionsTest.new(:@lisa, :@homer, 0)
