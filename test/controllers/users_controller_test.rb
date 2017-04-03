require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    process_scenario 'simpsons'
    sign_in @homer
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should show user" do
    get user_url(@homer)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@homer)
    assert_response :success
  end

  test "should update user" do
    patch user_url(@homer), params: { user: { first_name: @homer.first_name, last_name: @homer.last_name, roles_mask: @homer.roles_mask } }
    assert_redirected_to user_url(@homer)
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@homer)
    end
    assert_redirected_to users_url
  end
end
