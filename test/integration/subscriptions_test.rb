require 'test_helper'

class SubscriptionsTest < ActionDispatch::IntegrationTest
  fixtures :all

  test "subscribe to a category" do
    get categories_path
    assert_response :success
    assert_nil session[:user]

    post_via_redirect create_session_path, { :username => users(:admin).name, :password => "adminpass" }, "HTTP_REFERER" => categories_path
    assert_response :success
    assert_equal session[:user], users(:admin)

    get category_path(categories(:two).id)
    assert_response :success
    assert_select "a", "Subscribe"

    count = Subscription.where(:user_id => users(:admin).id).count

    get_via_redirect subscribe_category_path(categories(:two).id), nil, "HTTP_REFERER" => category_path(categories(:two).id)
    assert_response :success
    assert_select "a", "Unsubscribe"

    assert_equal Subscription.where(:user_id => users(:admin).id).count, count + 1
  end

  test "unsubscribe from a category" do
    get categories_path
    assert_response :success
    assert_nil session[:user]

    post_via_redirect create_session_path, { :username => users(:admin).name, :password => "adminpass" }, "HTTP_REFERER" => categories_path
    assert_response :success
    assert_equal session[:user], users(:admin)

    get category_path(categories(:one).id)
    assert_response :success
    assert_select "a", "Unsubscribe"

    count = Subscription.where(:user_id => users(:admin).id).count

    get_via_redirect unsubscribe_category_path(categories(:one).id), nil, "HTTP_REFERER" => category_path(categories(:one).id)
    assert_response :success
    assert_select "a", "Subscribe"

    assert_equal Subscription.where(:user_id => users(:admin).id).count, count - 1
  end
end
