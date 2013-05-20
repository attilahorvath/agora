class Category < ActiveRecord::Base
  belongs_to :user
  has_many :topics
  attr_accessible :name, :user
  validates :name, :presence => true, :uniqueness => true
  validates :user_id, :presence => true

  def self.search(query)
    if query.blank?
      nil
    else
      find :all, :conditions => ["name LIKE ?", "%#{ query }%"]
    end
  end
end
