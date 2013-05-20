class TopicsController < ApplicationController
  def show
    @topic = Topic.find params[:id]
    @comments = @topic.grouped_comments
    if current_user
      @comment = Comment.new
    end
  end

  def new
    category = params[:category_id] ? Category.find(params[:category_id]) : Category.first

    @topic = Topic.new
    @topic.category = category
  end

  def create
    if current_user
      @topic = Topic.new(params[:topic])
      @topic.user = current_user
      if @topic.save
        flash[:notice] = "Topic created."
        redirect_to topic_url(@topic)
      else
        render :new
      end
    else
      flash[:error] = "You have to be logged in to access this page."
      redirect_to :root
    end
  end

  def vote
    if current_user
      @topic = Topic.find params[:id]
      positive = params[:positive] == "true"
      unless TopicVote.find_by_user_id_and_topic_id current_user.id, @topic.id
        @vote = TopicVote.new(:user_id => current_user.id, :topic_id => @topic.id, :positive => positive)
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
