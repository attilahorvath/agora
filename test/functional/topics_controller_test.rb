require 'test_helper'

class TopicsControllerTest < ActionController::TestCase
  setup do
    @request.env["HTTP_REFERER"] = categories_path
  end

  test "should get show while not logged in" do
    get :show, :id => topics(:one).id
    assert_response :success
    assert_not_nil assigns(:topic)
    assert_not_nil assigns(:comments)
    assert_nil assigns(:comment)
  end

  test "should get show while logged in" do
    get :show, { :id => topics(:one).id }, :user => users(:admin)
    assert_response :success
    assert_not_nil assigns(:topic)
    assert_not_nil assigns(:comments)
    assert_not_nil assigns(:comment)
  end

  test "should get new" do
    get :new, :category_id => categories(:one).id
    assert_response :success
    assert_not_nil assigns(:topic)
  end

  test "should post create with valid data while logged in" do
    post :create, { :topic => { :title => "New topic", :description => "Description.", :category_id => categories(:one).id } }, :user => users(:admin)
    assert_response :redirect
    assert_not_nil assigns(:topic)
    assert_equal flash[:notice], "Topic created."
  end

  test "should post create with invalid data while logged in" do
    post :create, { :topic => { :category_id => categories(:one).id } }, :user => users(:admin)
    assert_response :success
  end

  test "should post create while not logged in" do
    post :create, { :topic => { :title => "New topic", :description => "Description.", :category_id => categories(:one).id } }
    assert_redirected_to :root
    assert_equal flash[:error], "You have to be logged in to access this page."
  end

  test "should post vote while logged in" do
    post :vote, { :id => topics(:two).id, :positive => true }, :user => users(:admin)
    assert_redirected_to categories_path
    assert_equal flash[:notice], "Vote recorded."
  end

  test "should post vote while not logged in" do
    post :vote, :id => topics(:one).id, :positive => true
    assert_redirected_to :root
    assert_equal flash[:error], "You have to be logged in to access this page."
  end
end
