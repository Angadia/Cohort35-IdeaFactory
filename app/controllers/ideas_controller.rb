class IdeasController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_idea, only: [:show, :edit, :update, :destroy]
  before_action :authorize!, only: [:edit, :update, :destroy]

  def index
    @ideas = Idea.all.order(updated_at: :desc)
  end

  def new
    @idea = Idea.new
  end

  def create
    @idea = Idea.new idea_params
    @idea.user = current_user
    if @idea.save
      flash[:notice] = "Idea Created Successfully"
      redirect_to @idea
    else
      flash.now[:alert] = @idea.errors.full_messages.join(', ')
      render :new
    end
  end

  def show
    @new_review = Review.new
    @reviews = @idea.reviews.order(created_at: :asc)
    @like = @idea.likes.find_by(user: current_user)
  end

  def edit

  end

  def update
    if @idea.update idea_params
      flash[:notice] = "Idea Updated Successfully"
      redirect_to @idea
    else
      flash.now[:alert] = @idea.errors.full_messages.join(', ')
      render :edit
    end
  end

  def destroy
    @idea.destroy
    flash[:notice] = "Idea Deleted Successfully"
    redirect_to root_path
  end

  private
  
  def find_idea
    @idea = Idea.find(params[:id])
  end
  
  def idea_params
    params.require(:idea).permit(:title, :description)
  end

  def authorize! 
    unless can?(:crud, @idea)
      redirect_to root_path, alert: 'Not Authorized' 
    end
  end
end
