require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "cannot save empty user model" do
    u = User.new
    assert !u.save, "empty user model saved"
  end

  test "cannot save user model without name" do
    u = User.new(:email => "user2@example.com", :password => "user2pass", :password_confirmation => "user2pass")
    assert !u.save, "user model without name saved"
  end

  test "cannot save user model without email" do
    u = User.new(:name => "user2", :password => "user2pass", :password_confirmation => "user2pass")
    assert !u.save, "user model without email saved"
  end

  test "cannot save user model without password" do
    u = User.new(:name => "user2", :email => "user2@example.com", :password_confirmation => "user2pass")
    assert !u.save, "user model without password saved"
  end

  test "cannot save user with existing name" do
    u = User.new(:name => users(:admin).name, :email => "user2@example.com", :password => "user2pass", :password_confirmation => "user2pass")
    assert !u.save, "user model with existing name saved"
  end

  test "cannot save user with existing email" do
    u = User.new(:name => "user2", :email => users(:admin).email, :password => "user2pass", :password_confirmation => "user2pass")
    assert !u.save, "user model with existing email saved"
  end

  test "cannot save user without password confirmation" do
    u = User.new(:name => "user2", :email => "user2@example.com", :password => "user2pass")
    assert !u.save, "user model without password confirmation saved"
  end

  test "cannot save user with wrong password confirmation" do
    u = User.new(:name => "user2", :email => "user2@example.com", :password => "user2pass", :password_confirmation => "wrongpass")
    assert !u.save, "user model with wrong password confirmation saved"
  end

  test "can save valid user model" do
    u = User.new(:name => "user2", :email => "user2@example.com", :password => "user2pass", :password_confirmation => "user2pass")
    assert u.save, "unable to save valid user model"
  end
end
