require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  setup do
    @request.env["HTTP_REFERER"] = categories_path
  end

  test "successful login" do
    post :create, { :username => users(:admin).name, :password => "adminpass" }
    assert_redirected_to categories_path
    assert_equal session[:user], users(:admin)
    assert_equal flash[:notice], "Successfully logged in."
  end

  test "unsuccessful login" do
    post :create, { :username => users(:admin).name, :password => "admin" }
    assert_redirected_to categories_path
    assert_nil session[:user]
    assert_equal flash[:error], 'Invalid username or password. <a href="/users/get_reset_key">Forgot your password?</a>'.html_safe
  end

  test "logout" do
    get :destroy, nil, { :user => users(:admin) }
    assert_redirected_to :root
    assert_nil session[:user]
    assert_equal flash[:notice], "Successfully logged out."
  end
end
