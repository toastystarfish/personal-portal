require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  ## TODO Check if a user can update their own role"
  setup do
    process_scenario :simpsons
  end

  data_test "users_create_permissions_tests" do
    create_user @datum.token, user_hash, @datum.expect_success, @datum.msg
  end

  data_test "users_edit_permissions_tests" do
    logged_in_user = instance_variable_get @datum.logged_in_user
    target_user = instance_variable_get @datum.target_user

    update_user(logged_in_user, target_user, @datum.attributes_hash,
      @datum.expect_success, @datum.msg)
  end

  data_test 'users_show_permissions_tests' do
    user_to_log_in = instance_variable_get @datum.user_to_log_in
    target_user = instance_variable_get @datum.target_user

    sign_in user_to_log_in
    get user_url(target_user)

    @datum.expect_success ?
      assert_response(:success, @datum.msg) :
      assert_redirected_to(root_path, @datum.msg)
  end

  data_test 'users_destroy_permissions_tests' do
    user_to_log_in = instance_variable_get @datum.user_to_log_in
    target_user = instance_variable_get @datum.target_user

    assert_difference('User.count', @datum.difference) do
      sign_in user_to_log_in
      delete user_url(target_user)
    end
  end

  # user should get the index page if he is logged in
  test 'user should get index' do
    sign_in @homer
    get users_url
    assert_response :success
  end

  # user should not get the index if he is not logged in
  test 'not logged user should not get index' do
    get users_url
    # redirected to sign_in page
    assert_response :redirect
  end

  test 'a non admin should not be able to update a role' do
    sign_in @bart
    patch user_url(@bart), params: {user: { password: 'ikeikeike',
      password_confirmation: 'ikeikeike', roles_mask: User.roles[:admin]}}

    assert_redirected_to user_url(@bart)
    assert_not_equal User.find(@bart.id).roles_mask, User.roles[:admin]
  end

  test 'cant create with nil invitation' do
    create_user 'abcdefg', bogus_user_hash, false,
    "User did not receive an invite"
  end

  private

  def bogus_user_hash
    {
      first_name: 'Peter', last_name: "Griffin",
      email: 'peter@paltucketpatriot.com', password: 'pass',
      password_confirmation: 'pass'
    }
  end

  def user_hash
    { first_name: "Montgomery", last_name: "Burns",
      email: @burns_invitation.email, password: "p@ssw0rd",
      password_confirmation: "p@ssw0rd"
    }
  end

  def update_user(current_user, target_user, attributes,
        should_be_authorized, msg)
    sign_in current_user
    get edit_user_url(target_user)

    if should_be_authorized
      assert_response :success, msg
    else
      assert_redirected_to root_path, msg
    end

    patch user_url(target_user), params: {user: attributes}
    if should_be_authorized
      assert_redirected_to user_path(target_user), msg
    else
      assert_redirected_to root_path, msg
    end
  end

  def create_user token, user_hash, expect_success, msg
    get new_user_url, params: { token: token }
    meth = expect_success ? :success_create_user : :fail_create_user
    send meth, token, user_hash, expect_success, msg
  end

  def success_create_user token, user_hash, expect_success, msg
    assert_response(:success, msg)
    assert_difference('User.count') do
        post users_url, params: {token: token, user: user_hash}
    end
    assert_redirected_to root_path
  end

  def fail_create_user token, user_hash, expect_success, msg
    assert_response(:redirect, msg)
    assert_no_difference('User.count') do
        post users_url, params: {token: token, user: user_hash}
      end
    assert_response :redirect, msg
  end
end
