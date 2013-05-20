require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test "cannot save empty category model" do
    c = Category.new
    assert !c.save, "empty category model saved"
  end

  test "cannot save category model without name" do
    c = Category.new(:user => users(:one))
    assert !c.save, "category model without name saved"
  end

  test "cannot save category model without user" do
    c = Category.new(:name => "Third category")
    assert !c.save, "category model without user saved"
  end

  test "can save valid category model" do
    c = Category.new(:name => "Third category", :user => users(:one))
    assert c.save, "unable to save valid category model"
  end

  test "empty search query" do
    assert_nil Category.search(""), "empty search query returned result"
  end

  test "valid search query without results" do
    assert_equal Category.search("does not exist").size, 0, "search returned wrong number of results"
  end

  test "valid search query with 2 results" do
    assert_equal Category.search("category").size, 2, "search returned wrong number of results"
  end
end
