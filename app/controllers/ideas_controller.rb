class IdeasController < ApplicationController
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

  private

  def idea_params
    params.require(:idea).permit(:title, :description)
  end
end
