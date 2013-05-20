class TopicVote < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic
  attr_accessible :user_id, :topic_id, :positive
end
