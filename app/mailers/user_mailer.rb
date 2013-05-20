class UserMailer < ActionMailer::Base
  default from: "agora@example.com"

  def welcome(user)
    @user = user
    mail(:to => @user.email, :subject => "Welcome to Agora!")
  end

  def reset_key(user)
    @user = user
    mail(:to => @user.email, :subject => "Password reset key for your Agora account.")
  end

  def comment_notification(comment)
    @user = comment.topic.user
    @comment = comment
    mail(:to => @user.email, :subject => "Someone commented on a topic created by you.")
  end

  def reply_notification(comment)
    @user = comment.parent.user
    @comment = comment
    mail(:to => @user.email, :subject => "Someone replied to a comment written by you.")
  end
end
