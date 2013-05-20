require 'test_helper'

class TopicTest < ActiveSupport::TestCase
  test "cannot save empty topic model" do
    t = Topic.new
    assert !t.save, "empty topic model saved"
  end

  test "cannot save topic model without title" do
    t = Topic.new(:description => "A description.", :category => categories(:one), :user => users(:admin))
    assert !t.save, "topic model without title saved"
  end

  test "cannot save topic model without description" do
    t = Topic.new(:title => "A topic.", :category => categories(:one), :user => users(:admin))
    assert !t.save, "topic model without description saved"
  end

  test "cannot save topic model without category" do
    t = Topic.new(:title => "A topic.", :description => "A description.", :user => users(:admin))
    assert !t.save, "topic model without category saved"
  end

  test "cannot save topic model without user" do
    t = Topic.new(:title => "A topic.", :description => "A description.", :description => "A description.", :category => categories(:one))
    assert !t.save, "topic model without user saved"
  end

  test "can save valid topic model" do
    t = Topic.new(:title => "A topic", :description => "A description.", :category => categories(:one), :user => users(:admin))
    assert t.save, "unable to save valid topic model"
  end

  test "empty search query" do
    assert_nil Topic.search(""), "empty search query returned results"
  end

  test "valid search query without results" do
    assert_equal Topic.search("does not exist").size, 0, "search query returned the wrong number of results"
  end

  test "valid search query with 3 results" do
    assert_equal Topic.search("topic").size, 3, "search query returned the wrong number of results"
  end

  test "positive votes" do
    assert_equal topics(:one).positive_votes, 1, "wrong number of positive votes returned"
  end

  test "negative votes" do
    assert_equal topics(:one).negative_votes, 2, "wrong number of negative votes returned"
  end

  test "votes" do
    assert_equal topics(:one).votes, -1, "wrong number of votes returned"
  end

  test "user voted is true" do
    assert topics(:one).user_voted?(users(:admin)), "user voted wrongly returned false"
  end

  test "user voted is false" do
    assert !topics(:two).user_voted?(users(:admin)), "user voted wrongly returned true"
  end

  test "grouped comments" do
    comments = topics(:one).grouped_comments
    assert_equal comments.size, 2, "grouped comments returned the wrong number of comment groups"
    assert_equal comments[nil].size, 2, "grouped comments returned the wrong number of root comments"
    assert_equal comments[comments(:two).id].size, 1, "grouped comments returned the wrong number of replies"
    assert_nil comments[comments(:one).id], "grouped comments wrongly returned replies to a comment"
  end
end
