class Comment < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user
  belongs_to :parent, :class_name => Comment
  has_many :comment_votes
  attr_accessible :text, :topic, :topic_id, :user, :parent, :parent_id
  validates :text, :presence => true
  validates :topic_id, :presence => true
  validates :user_id, :presence => true

  def positive_votes
    CommentVote.where(:comment_id => self.id, :positive => true).count
  end

  def negative_votes
    CommentVote.where(:comment_id => self.id, :positive => false).count
  end

  def votes
    positive_votes - negative_votes
  end

  def user_voted?(user)
    if user
      CommentVote.find_by_user_id_and_comment_id user.id, self.id
    end
  end

  def set_deleted(user)
    if user == self.user
      self.deleted = true
      self.save
    else
      false
    end
  end
end
