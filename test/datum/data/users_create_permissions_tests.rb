UsersCreatePermissionsTest = Datum.new(:token, :expect_success, :msg)
#burn's unaccepted token
UsersCreatePermissionsTest.new "xxxxxxxxxxxxx", true,
"User not created with correct token and unaccepted invite"
#fake token
UsersCreatePermissionsTest.new "1337h4ck1ng70k3N", false,
"User created with incorrect token"
#lisa's accepted token
UsersCreatePermissionsTest.new "ababababababab", false,
"User created with correct token and already accepted invite"
