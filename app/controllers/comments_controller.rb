class CommentsController < ApplicationController
  def create
    if current_user
      @comment = Comment.new(params[:comment])
      @comment.user = current_user
      if @comment.save
        if @comment.user != @comment.topic.user && @comment.topic.user.comment_notification
          UserMailer.comment_notification(@comment).deliver
        end
        flash[:notice] = "Comment submitted."
      else
        flash[:error] = "Unable to submit comment."
      end
      redirect_to :back
    else
      flash[:error] = "You have to be logged in to access this page."
      redirect_to :root
    end
  end

  def update
    if current_user
      @comment = Comment.find params[:id]
      @comment.text = params[:comment][:text]
      if @comment.user == session[:user] && @comment.save
        flash[:notice] = "Comment edited."
      else
        flash[:error] = "Unable to edit comment."
      end
      redirect_to :back
    else
      flash[:error] = "You have to be logged in to access this page."
      redirect_to :root
    end
  end

  def delete
    if current_user
      @comment = Comment.find params[:id]
      if @comment && @comment.user == current_user && @comment.set_deleted(session[:user])
        flash[:notice] = "Comment deleted."
      else
        flash[:error] = "Unable to delete comment."
      end
      redirect_to :back
    else
      flash[:error] = "You have to be logged in to access this page."
      redirect_to :root
    end
  end

  def reply
    if current_user
      @parent = Comment.find params[:id]
      @comment = Comment.new params[:comment]
      @comment.user = current_user
      @comment.topic = @parent.topic
      @comment.parent = @parent
      if @comment.save
        if @comment.parent && @comment.parent.user != @comment.user && @comment.parent.user.reply_notification
          UserMailer.reply_notification(@comment).deliver
        end
        flash[:notice] = "Reply submitted."
      else
        flash[:error] = "Unable to submit reply."
      end
      redirect_to :back
    else
      flash[:error] = "You have to be logged in to access this page."
      redirect_to :root
    end
  end

  def vote
    if current_user
      @comment = Comment.find params[:id]
      positive = params[:positive]
      if !@comment.user_voted?(session[:user])
        @vote = CommentVote.new(:user_id => session[:user].id, :comment_id => @comment.id, :positive => positive)
        if @vote.save
          flash[:notice] = "Vote recorded."
        else
          flash[:error] = "Unable to record vote."
        end
      end
      redirect_to :back
    else
      flash[:error] = "You have to be logged in to access this page."
      redirect_to :root
    end
  end
end
