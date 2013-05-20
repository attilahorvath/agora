class Topic < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :comments
  has_many :topic_votes
  attr_accessible :description, :title, :category, :category_id, :user
  validates :title, :presence => true
  validates :description, :presence => true
  validates :user_id, :presence => true
  validates :category_id, :presence => true

  def self.search(query)
    if query.blank?
      nil
    else
      find :all, :conditions => ["title LIKE ?", "%#{ query }%"]
    end
  end

  def positive_votes
    TopicVote.where(:topic_id => self.id, :positive => true).count
  end

  def negative_votes
    TopicVote.where(:topic_id => self.id, :positive => false).count
  end

  def votes
    positive_votes - negative_votes
  end

  def user_voted?(user)
    if user
      TopicVote.find_by_user_id_and_topic_id user.id, self.id
    end
  end

  def grouped_comments
    comments.sort_by{|c| c.votes }.reverse.group_by{|c| c.parent_id }
  end
end
