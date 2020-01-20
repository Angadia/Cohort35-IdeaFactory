class IdeasController < ApplicationController
  before_action :find_idea, only: [:show, :edit, :update, :destroy]

  def index
    @ideas = Idea.all.order(updated_at: :desc)
  end

  def new
    @idea = Idea.new
  end

  def create
    @idea = Idea.new idea_params
    if @idea.save
      flash[:notice] = "Idea Created Successfully"
      redirect_to @idea
    else
      flash.now[:alert] = @idea.errors.full_messages.join(', ')
      render :new
    end
  end

  def show
    
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
end
