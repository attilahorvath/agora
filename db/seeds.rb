# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = User.create(:name => "admin", :email => "admin@example.com", :password => "adminpass", :password_confirmation => "adminpass")
user1 = User.create(:name => "user1", :email => "user1@example.com", :password => "user1pass", :password_confirmation => "user1pass")
user2 = User.create(:name => "user2", :email => "user2@example.com", :password => "user2pass", :password_confirmation => "user2pass")
user3 = User.create(:name => "user3", :email => "user3@example.com", :password => "user3pass", :password_confirmation => "user3pass")

category1 = Category.create(:name => "First category", :user => admin)
category2 = Category.create(:name => "Second category", :user => user2)
category3 = Category.create(:name => "Third category", :user => admin)

topic1 = Topic.create(:title => "First topic", :description => "The description of the First topic.", :category => category1, :user => admin)
topic2 = Topic.create(:title => "Another topic", :description => "This is another topic.", :category => category1, :user => user1)
topic3 = Topic.create(:title => "First topic in the Second category", :description => "This is the first topic in the Second category.", :category => category2, :user => user2)
topic4 = Topic.create(:title => "A topic", :description => "A description.", :category => category3, :user => user2)
topic5 = Topic.create(:title => "Second topic", :description => "A second description.", :category => category2, :user => user1)
topic6 = Topic.create(:title => "Yet another topic", :description => "The description of the Yet another topic.", :category => category1, :user => user2)
topic7 = Topic.create(:title => "Third topic", :description => "A third description.", :category => category2, :user => admin)

Comment.create(:text => "First comment.", :topic => topic1, :user => admin)
Comment.create(:text => "My first comment.", :topic => topic1, :user => user2)
Comment.create(:text => "A comment.", :topic => topic3, :user => user3)
Comment.create(:text => "A reply.", :topic => topic3, :user => admin, :parent_id => 3)
Comment.create(:text => "First comment.", :topic => topic4, :user => user3)
Comment.create(:text => "Test comment.", :topic => topic1, :user => user3)
Comment.create(:text => "Another comment.", :topic => topic2, :user => admin)
Comment.create(:text => "Another reply.", :topic => topic3, :user => admin, :parent_id => 4)
Comment.create(:text => "Yet another comment.", :topic => topic3, :user => user2)
Comment.create(:text => "The only comment here.", :topic => topic6, :user => user3)
Comment.create(:text => "Test reply.", :topic => topic1, :user => user1, :parent_id => 6)
Comment.create(:text => "A new reply.", :topic => topic1, :user => user2, :parent_id => 11)
Comment.create(:text => "Second comment.", :topic => topic1, :user => admin, :parent_id => 1)
Comment.create(:text => "Third comment.", :topic => topic1, :user => admin, :parent_id => 1)

Subscription.create(:user_id => 1, :category_id => 1)
Subscription.create(:user_id => 2, :category_id => 1)
Subscription.create(:user_id => 2, :category_id => 2)
Subscription.create(:user_id => 2, :category_id => 3)
Subscription.create(:user_id => 1, :category_id => 3)
Subscription.create(:user_id => 4, :category_id => 2)
Subscription.create(:user_id => 4, :category_id => 1)

TopicVote.create(:user_id => 1, :topic_id => 1, :positive => true)
TopicVote.create(:user_id => 1, :topic_id => 2, :positive => true)
TopicVote.create(:user_id => 1, :topic_id => 3, :positive => false)
TopicVote.create(:user_id => 3, :topic_id => 5, :positive => false)
TopicVote.create(:user_id => 2, :topic_id => 7, :positive => true)
TopicVote.create(:user_id => 2, :topic_id => 5, :positive => false)
TopicVote.create(:user_id => 2, :topic_id => 2, :positive => true)
TopicVote.create(:user_id => 3, :topic_id => 4, :positive => false)
TopicVote.create(:user_id => 2, :topic_id => 5, :positive => false)
TopicVote.create(:user_id => 2, :topic_id => 1, :positive => true)

CommentVote.create(:user_id => 1, :comment_id => 1, :positive => true)
CommentVote.create(:user_id => 1, :comment_id => 2, :positive => false)
CommentVote.create(:user_id => 1, :comment_id => 3, :positive => true)
CommentVote.create(:user_id => 3, :comment_id => 5, :positive => false)
CommentVote.create(:user_id => 4, :comment_id => 8, :positive => false)
CommentVote.create(:user_id => 3, :comment_id => 9, :positive => true)
CommentVote.create(:user_id => 2, :comment_id => 5, :positive => false)
CommentVote.create(:user_id => 2, :comment_id => 4, :positive => false)
CommentVote.create(:user_id => 4, :comment_id => 3, :positive => false)
CommentVote.create(:user_id => 3, :comment_id => 2, :positive => true)
CommentVote.create(:user_id => 2, :comment_id => 7, :positive => true)
CommentVote.create(:user_id => 2, :comment_id => 6, :positive => true)
CommentVote.create(:user_id => 3, :comment_id => 4, :positive => true)
CommentVote.create(:user_id => 3, :comment_id => 3, :positive => false)
CommentVote.create(:user_id => 4, :comment_id => 2, :positive => false)

