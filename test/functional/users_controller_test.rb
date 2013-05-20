require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @request.env["HTTP_REFERER"] = categories_path
  end

  test "index should redirect to root" do
    get :index
    assert_redirected_to :root
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:user)
  end

  test "should post create with valid data" do
    post :create, :user => { :name => "user2", :email => "user2@example.com", :password => "user2pass", :password_confirmation => "user2pass" }
    assert_redirected_to :action => :edit
    assert_not_nil assigns(:user)
    assert_equal flash[:notice], "Successfully registered."
  end

  test "should post create with invalid data" do
    post :create, :user => { :name => users(:admin).name, :email => "user2@example.com", :password => "user2pass", :password_confirmation => "user2pass" }
    assert_response :success
  end

  test "should get show" do
    get :show, :id => users(:admin).id
    assert_response :success
    assert_not_nil assigns(:user)
  end

  test "should get edit while logged in" do
    get :edit, nil, { :user => users(:admin) }
    assert_response :success
    assert_not_nil assigns(:user)
  end

  test "should get edit while not logged in" do
    get :edit
    assert_redirected_to :root
    assert_equal flash[:error], "You have to be logged in to access this page."
  end

  test "should post update with valid data while logged in" do
    post :update, { :user => { :email => "newadmin@example.com" } }, :user => users(:admin)
    assert_redirected_to :action => :edit
    assert_equal flash[:notice], "Options changed."
  end

  test "should post update with invalid data while logged in" do
    post :update, { :user => { :password => "newpass", :password_confirmation => "new" } }, :user => users(:admin)
    assert_redirected_to :action => :edit
  end

  test "should post update while not logged in" do
    post :update
    assert_redirected_to :root
    assert_equal flash[:error], "You have to be logged in to access this page."
  end

  test "should get get_reset_key while logged in" do
    get :get_reset_key, nil, :user => users(:admin)
    assert_redirected_to :root
    assert_equal flash[:error], "You have to log out to access this page."
  end

  test "should get get_reset_key while not logged in" do
    get :get_reset_key
    assert_response :success
  end

  test "should post send_reset_key while logged in" do
    post :send_reset_key, nil, :user => users(:admin)
    assert_redirected_to :root
    assert_equal flash[:error], "You have to log out to access this page."
  end

  test "should post send_reset_key with valid data while not logged in" do
    post :send_reset_key, :email => users(:admin).email
    assert_redirected_to :root
    assert_equal flash[:notice], "Reset key sent."
  end

  test "should post send_reset_key with invalid data while not logged in" do
    post :send_reset_key, :email => "invalid@example.com"
    assert_redirected_to categories_path
    assert_equal flash[:error], "Invalid address."
  end

  test "should get reset_password while logged in" do
    get :reset_password, nil, :user => users(:admin)
    assert_redirected_to :root
    flash[:error] = "You have to log out to access this page."
  end

  test "should get reset_password with valid data while not logged in" do
    get :reset_password, :id => users(:reset).id, :reset_key => users(:reset).reset_key
    assert_redirected_to :edit_user
    assert_equal flash[:notice], "You can now enter a new password."
  end

  test "should get reset_password with invalid data while not logged in" do
    get :reset_password, :id => users(:admin), :reset_key => "reset"
    assert_redirected_to :root
    assert_equal flash[:error], "Invalid user ID or reset key."
  end
end
