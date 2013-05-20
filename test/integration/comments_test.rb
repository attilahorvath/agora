require 'test_helper'

class CommentsTest < ActionDispatch::IntegrationTest
  fixtures :all

  test "write a comment" do
    post_via_redirect create_session_path, { :username => users(:admin).name, :password => "adminpass" }, "HTTP_REFERER" => root_path
    assert_response :success
    assert_equal session[:user], users(:admin)

    get topic_path(topics(:one).id), nil, :user => users(:admin)
    assert_response :success

    count = Comment.where(:topic_id => topics(:one).id).size

    post_via_redirect comments_path, { :comment => { :text => "Test comment.", :topic_id => topics(:one).id } }, :user => users(:admin), "HTTP_REFERER" => topic_path(topics(:one).id)
    assert_response :success
    assert_select "p", "Test comment."

    assert_equal Comment.where(:topic_id => topics(:one).id).size, count + 1
  end

  test "write a reply" do
    post_via_redirect create_session_path, { :username => users(:admin).name, :password => "adminpass" }, "HTTP_REFERER" => root_path
    assert_response :success
    assert_equal session[:user], users(:admin)

    get topic_path(topics(:one).id), nil, :user => users(:admin)
    assert_response :success

    count = Comment.where(:parent_id => comments(:one).id).size

    post_via_redirect reply_comment_path(comments(:one).id), { :comment => { :text => "Test reply.", :topic_id => topics(:one).id } }, :user => users(:admin), "HTTP_REFERER" => topic_path(topics(:one).id)
    assert_response :success
    assert_select "p", "Test reply."

    assert_equal Comment.where(:parent_id => comments(:one).id).size, count + 1
  end

  test "edit a comment" do
    post_via_redirect create_session_path, { :username => users(:admin).name, :password => "adminpass" }, "HTTP_REFERER" => root_path
    assert_response :success
    assert_equal session[:user], users(:admin)

    get topic_path(topics(:one).id), nil, :user => users(:admin)
    assert_response :success

    count = Comment.where(:topic_id => topics(:one).id).size

    put_via_redirect comment_path(comments(:one).id), { :comment => { :text => "Test edit." } }, :user => users(:admin), "HTTP_REFERER" => topic_path(topics(:one).id)
    assert_response :success
    assert_select "p", "Test edit."

    assert_equal Comment.where(:topic_id => topics(:one).id).size, count
  end

  test "delete a comment" do
    post_via_redirect create_session_path, { :username => users(:admin).name, :password => "adminpass" }, "HTTP_REFERER" => root_path
    assert_response :success
    assert_equal session[:user], users(:admin)

    get topic_path(topics(:one).id), nil, :user => users(:admin)
    assert_response :success

    get_via_redirect delete_comment_path(comments(:one).id), nil, :user => users(:admin), "HTTP_REFERER" => topic_path(topics(:one).id)
    assert_response :success
    assert_equal Comment.find(comments(:one).id).deleted, true
  end

  test "vote for a comment" do
    post_via_redirect create_session_path, { :username => users(:admin).name, :password => "adminpass" }, "HTTP_REFERER" => root_path
    assert_response :success
    assert_equal session[:user], users(:admin)

    get topic_path(topics(:one).id), nil, :user => users(:admin)
    assert_response :success

    count = comments(:two).votes

    post_via_redirect vote_comment_path(comments(:two).id, true), nil, :user => users(:admin), "HTTP_REFERER" => topic_path(topics(:one).id)
    assert_response :success
    assert_equal comments(:two).votes, count + 1
  end
end
