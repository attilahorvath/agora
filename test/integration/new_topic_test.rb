require 'test_helper'

class NewTopicTest < ActionDispatch::IntegrationTest
  fixtures :all

  test "create new topic" do
    get category_path(categories(:one).id)
    assert_response :success
    assert_nil session[:user]

    post_via_redirect create_session_path, { :username => users(:admin).name, :password => "adminpass" }, "HTTP_REFERER" => category_path(categories(:one))
    assert_response :success
    assert_equal session[:user], users(:admin)

    get new_topic_path(categories(:one).id)
    assert_response :success
    assert_not_nil assigns(:topic)

    count = Topic.all.size

    post_via_redirect topics_path, { :topic => { :title => "A new category", :description => "A new description.", :category_id => categories(:one).id } }, :user => users(:admin)
    assert_response :success
    assert_select "p", "There are no comments yet."

    assert_equal Topic.all.size, count + 1
  end
end
