require 'test_helper'

class NewCategoryTest < ActionDispatch::IntegrationTest
  fixtures :all

  test "create new category" do
    get categories_path
    assert_response :success
    assert_nil session[:user]

    post_via_redirect create_session_path, { :username => users(:admin).name, :password => "adminpass" }, "HTTP_REFERER" => categories_path
    assert_response :success
    assert_equal session[:user], users(:admin)

    get new_category_path
    assert_response :success
    assert_not_nil assigns(:category)

    count = Category.all.size

    post_via_redirect categories_path, { :category => { :name => "A new category" } }, :user => users(:admin)
    assert_response :success
    assert_select "p", "There are no topics yet."

    assert_equal Category.all.size, count + 1
  end
end
