class User < ActiveRecord::Base
  has_many :topics
  has_many :comments
  has_many :subscriptions
  has_many :topic_votes
  has_many :comment_votes
  attr_accessible :email, :name, :password, :password_confirmation, :encrypted_password, :comment_notification, :reply_notification, :reset_key
  attr_accessor :password
  validates :name, :presence => true, :uniqueness => true
  validates :email, :presence => true, :uniqueness => true
  validates :password, :presence => true, :confirmation => true, :on => :create
  validates :password, :confirmation => true, :if => Proc.new {|user| !user.password.blank? }
  validates :password_confirmation, :presence => true, :if => Proc.new {|user| !user.password.blank? }

  before_save :encrypt_password

  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest(salt + password)
  end

  def self.authenticate(name, password)
    user = User.find_by_name name
    user && user.authenticated?(password) ? user : nil
  end

  def encrypt_password
    return if password.blank?
    if new_record?
      self.salt = Digest::SHA1.hexdigest(Time.now.to_s + email + name)
    end
    self.encrypted_password = User.encrypt(password, salt)
  end

  def authenticated?(password)
    encrypted_password == User.encrypt(password, salt)
  end
end
