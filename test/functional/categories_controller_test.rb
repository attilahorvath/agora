require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  setup do
    @request.env["HTTP_REFERER"] = categories_path
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:categories)
  end

  test "should get show with id" do
    get :show, :id => categories(:one).id
    assert_response :success
    assert_not_nil assigns(:category)
    assert_not_nil assigns(:topics)
  end

  test "should get show without id" do
    get :show
    assert_response :success
    assert_not_nil assigns(:topics)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should post create with valid data" do
    post :create, { :category => { :name => "Third category" } }, { :user => users(:admin) }
    assert_redirected_to category_path(assigns(:category))
    assert_equal flash[:notice], "Category created."
  end

  test "should post create with invalid data" do
    post :create, { :category => {} }, { :user => users(:admin) }
    assert_response :success
    assert_not_nil assigns(:category)
  end

  test "should get search" do
    get :search, :query => "category"
    assert_response :success
  end

  test "should get subscribe while logged in" do
    post :subscribe, { :id => categories(:two).id }, :user => users(:admin)
    assert_redirected_to categories_path
    assert_equal flash[:notice], "Subscribed to the category #{ categories(:two).name }"
  end

  test "should get subscribe while not logged in" do
    get :subscribe, { :id => categories(:one).id }
    assert_redirected_to :root
    assert_equal flash[:error], "You have to be logged in to access this page."
  end

  test "should get unsubscribe while logged in" do
    get :unsubscribe, { :id => categories(:one).id }, :user => users(:admin)
    assert_redirected_to categories_path
    assert_equal flash[:notice], "Unsubscribed from the category #{ categories(:one).name }"
  end

  test "should get unsubscribe while not logged in" do
    get :unsubscribe, { :id => categories(:one).id }
    assert_redirected_to :root
    assert_equal flash[:error], "You have to be logged in to access this page."
  end
end
