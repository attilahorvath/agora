require 'test_helper'

class ResetPasswordTest < ActionDispatch::IntegrationTest
  fixtures :all

  test "reset password" do
    get root_path
    assert_response :success
    assert_nil session[:user]

    post_via_redirect create_session_path, { :username => users(:admin).name, :password => "pass" }, "HTTP_REFERER" => root_path
    assert_response :success
    assert_nil session[:user]

    get get_reset_key_path
    assert_response :success

    post send_reset_key_path, :email => users(:admin).email
    reset_key = assigns(:user).reset_key

    get_via_redirect reset_password_path(users(:admin).id, reset_key)
    assert_response :success
    assert_equal assigns(:user), users(:admin)
    assert_equal session[:user], users(:admin)
  end
end
