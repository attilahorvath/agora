class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @filter = (params[:filter] || :popular).to_sym
    if params[:id]
      @category = Category.find params[:id]
      @topics = @category.topics
    else
      if current_user
        category_ids = Subscription.where(:user_id => current_user.id).map(&:category_id)
        @topics = Topic.where(:category_id => category_ids).all
      else
        @topics = Topic.all
      end
    end
    case @filter
      when :popular
        @topics.sort_by!{|t| t.votes }.reverse!
      when :controversial
        @topics.sort_by!{|t| (t.positive_votes - t.negative_votes).abs }
      when :new
        @topics.sort_by!{|t| t.created_at }.reverse!
    end
  end

  def new
    @category = Category.new
  end

  def create
    if current_user
      @category = Category.new(params[:category])
      @category.user = current_user
      if @category.save
        flash[:notice] = "Category created."
        redirect_to category_url(@category)
      else
        render :new
      end
    end
  end

  def search
    @query = params[:query]
    @categories = Category.search(@query)
    @topics = Topic.search(@query)
  end

  def subscribe
    if current_user
      category = Category.find params[:id]
      unless Subscription.find_by_user_id_and_category_id current_user.id, category.id
        Subscription.create(:user_id => current_user.id, :category_id => category.id)
      end
      flash[:notice] = "Subscribed to the category #{ category.name }"
      redirect_to :back
    else
      flash[:error] = "You have to be logged in to access this page."
      redirect_to :root
    end
  end

  def unsubscribe
    if current_user
      category = Category.find params[:id]
      if subscription = Subscription.find_by_user_id_and_category_id(current_user.id, category.id)
        subscription.delete
      end
      flash[:notice] = "Unsubscribed from the category #{ category.name }"
      redirect_to :back
    else
      flash[:error] = "You have to be logged in to access this page."
      redirect_to :root
    end
  end
end
