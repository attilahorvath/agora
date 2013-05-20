require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test "cannot save empty comment model" do
    c = Comment.new
    assert !c.save, "empty comment model saved"
  end

  test "cannot save comment model without text" do
    c = Comment.new(:topic => topics(:one), :user => users(:one))
    assert !c.save, "comment model without text saved"
  end

  test "cannot save comment model without topic" do
    c = Comment.new(:text => "A comment.", :user => users(:one))
    assert !c.save, "comment model without topic saved"
  end

  test "cannot save comment model without user" do
    c = Comment.new(:text => "A comment.", :topic => topics(:one))
    assert !c.save, "comment model without user saved"
  end

  test "can save valid comment model" do
    c = Comment.new(:text => "A comment.", :topic => topics(:one), :user => users(:one))
    assert c.save, "unable to save valid comment model"
  end

  test "positive votes" do
    assert_equal comments(:one).positive_votes, 2, "wrong number of positive votes returned"
  end

  test "negative votes" do
    assert_equal comments(:one).negative_votes, 1, "wrong number of negative votes returned"
  end

  test "votes" do
    assert_equal comments(:one).votes, 1, "wrong number of votes returned"
  end

  test "user voted is true" do
    assert comments(:one).user_voted?(users(:admin)), "user voted wrongly returned false"
  end

  test "user voted is false" do
    assert !comments(:two).user_voted?(users(:admin)), "user voted wrongly returned true"
  end

  test "successfully set deleted" do
    comments(:one).set_deleted(comments(:one).user)
    assert comments(:one).deleted, "failed to set comment deleted"
  end

  test "fail to set deleted" do
    comments(:one).set_deleted(users(:one))
    assert !comments(:one).deleted, "comment wrongly set deleted"
  end
end
