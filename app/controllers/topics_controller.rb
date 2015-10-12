class TopicsController < ApplicationController

  before_action :require_sign_in, except: [:index, :show]
  before_action :authorize_user, except: [:index, :show]
  before_action :load_topic, only: [:show, :edit, :update, :destroy]
  before_action :load_labels, only: [:create, :update]

  def index
    @topics = Topic.all
  end

  def show
  end

  def new
    if current_user.admin?
      @topic = Topic.new
    else
      flash[:error] = "Moderators cannot create topics."
      redirect_to topics_path
    end
  end

  def create
    if current_user.admin?
      @topic = Topic.new(topic_params)
      if @topic.save
        redirect_to @topic, notice: "Topic was saved successfully."
      else
        flash[:error] = "Error creating topic. Please try again."
        render :new
      end
    else
      flash[:error] = "Moderators cannot create topics."
      redirect_to topics_path
    end
  end

  def edit
  end

  def update
    @topic.assign_attributes(topic_params)

    if @topic.save
      flash[:notice] = "Topic was updated."
      redirect_to @topic
    else
      flash[:error] = "Error saving topic. Please try again."
      render :edit
    end
  end

  def destroy
    if current_user.admin?

      if @topic.destroy
        flash[:notice] = "\"#{@topic.name}\" was deleted successfully."
        redirect_to action: :index
      else
        flash[:error] = "There was an error deleting the topic."
        render :show
      end
    else
      flash[:error] = "Moderators cannot delete topics."
      redirect_to topics_path        
    end

  end

  private

  def load_topic
    @topic = Topic.find(params[:id])
  end

  def load_labels
    @topic.labels = Label.update_labels(params[:topic][:labels])
  end

  def topic_params
    params.require(:topic).permit(:name, :description, :public)
  end

  def authorize_user
      unless current_user.admin? || current_user.moderator?
        flash[:error] = "You must be an admin to do that."
        redirect_to topics_path
      end      
  end
end
