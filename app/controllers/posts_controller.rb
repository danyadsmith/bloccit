class PostsController < ApplicationController

  before_action :require_sign_in, except: :show
  before_action :authorize_user, except: [:show, :new, :create]
  before_action :load_topic, only: [:new, :show, :create]
  before_action :load_post, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = @topic.posts.build(post_params)
    @post.user = current_user

    if @post.save
      flash[:notice] = "Post was saved."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def edit
  end

  def update
    @post.assign_attributes(post_params)

    if @post.save
      flash[:notice] = "Post was updated."
      redirect_to [@post.topic, @post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :edit
    end
  end

  def destroy
    if @post.destroy
      flash[:notice] = "\"#{@post.title}\" was deleted successfully."
      redirect_to @post.topic
    else
      flash[:error] = "There was an error deleting the post."
      render :show
    end
  end

  private

  def load_post
    @post = Post.find(params[:id])
  end

  def load_topic
    @topic = Topic.find(params[:topic_id])
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def authorize_user
    post = Post.find(params[:id])
  
    unless current_user == post.user || current_user.admin? || (current_user.moderator? && params[:action] != "destroy")
      flash[:error] = "You must be an admin to do that."
      redirect_to [post.topic, post]
    end

  end

end
