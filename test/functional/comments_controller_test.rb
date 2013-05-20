require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  setup do
    @request.env["HTTP_REFERER"] = categories_path
  end

  test "should post create with valid data while logged in" do
    post :create, { :comment => { :text => "A comment.", :topic_id => topics(:one).id } }, :user => users(:admin)
    assert_redirected_to categories_path
    assert_equal flash[:notice], "Comment submitted."
  end

  test "should post create with invalid data while logged in" do
    post :create, { :comment => { } }, :user => users(:admin)
    assert_redirected_to categories_path
    assert_equal flash[:error], "Unable to submit comment."
  end

  test "should post create while not logged in" do
    post :create, :comment => { :text => "A comment.", :topic_id => topics(:one).id }
    assert_redirected_to :root
    assert_equal flash[:error], "You have to be logged in to access this page."
  end

  test "should post update with valid data while logged in" do
    post :update, { :id => comments(:one).id, :comment => { :text => "Updated comment." } }, :user => users(:admin)
    assert_redirected_to categories_path
    assert_equal flash[:notice], "Comment edited."
  end

  test "should post update with invalid data while logged in" do
    post :update, { :id => comments(:one).id, :comment => { :text => "Updated comment." } }, :user => users(:one)
    assert_redirected_to categories_path
    assert_equal flash[:error], "Unable to edit comment."
  end

  test "should post update while not logged in" do
    post :update, :id => comments(:one).id, :comment => { :text => "Updated comment." }
    assert_redirected_to :root
    assert_equal flash[:error], "You have to be logged in to access this page."
  end

  test "should get delete with valid data while logged in" do
    get :delete, { :id => comments(:one).id }, :user => users(:admin)
    assert_redirected_to categories_path
    assert_equal flash[:notice], "Comment deleted."
  end

  test "should get delete with invalid data while logged in" do
    get :delete, { :id => comments(:one).id }, :user => users(:one)
    assert_redirected_to categories_path
    assert_equal flash[:error], "Unable to delete comment."
  end

  test "should get delete while not logged in" do
    get :delete, :id => comments(:one).id
    assert_redirected_to :root
    assert_equal flash[:error], "You have to be logged in to access this page."
  end

  test "should post reply with valid data while logged in" do
    post :reply, { :id => comments(:one).id, :comment => { :text => "A reply." } }, :user => users(:admin)
    assert_redirected_to categories_path
    assert_equal flash[:notice], "Reply submitted."
  end

  test "should post reply with invalid data while logged in" do
    post :reply, { :id => comments(:one).id, :comment => { } }, :user => users(:admin)
    assert_redirected_to categories_path
    assert_equal flash[:error], "Unable to submit reply."
  end

  test "should post reply while not logged in" do
    post :reply, :id => comments(:one).id, :comment => { :text => "A reply." }
    assert_redirected_to :root
    assert_equal flash[:error], "You have to be logged in to access this page."
  end

  test "should post vote while logged in" do
    post :vote, { :id => comments(:two).id, :positive => true }, :user => users(:admin)
    assert_redirected_to categories_path
    assert_equal flash[:notice], "Vote recorded."
  end

  test "should post vote while not logged in" do
    post :vote, :id => comments(:one).id, :positive => true
    assert_redirected_to :root
    assert_equal flash[:error], "You have to be logged in to access this page."
  end
end
