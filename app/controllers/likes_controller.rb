class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_idea, only: [:create]
  before_action :authorize!, only: [:create]

  def create
    like = Like.new(user: current_user, idea: @idea)
    if like.save
      flash[:notice] = "Idea Liked"
    else
      flash[:alert] = like.errors.full_messages.join(", ")
    end
    redirect_to :root
  end

  def destroy
    like = current_user.likes.find params[:id]
    if can? :destroy, like
      like.destroy
      flash[:notice] = 'Idea Unliked'
    else
      flash[:alert] = "Can't delete like!"
    end
    redirect_to :root
  end

  private

  def find_idea
    @idea = Idea.find params[:idea_id]
  end

  def authorize!
    unless can?(:like, @idea)
      flash[:alert] = "Not Authorized"
      redirect_to idea_path(@idea)
    end
  end
end
