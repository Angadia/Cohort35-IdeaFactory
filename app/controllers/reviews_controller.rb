class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    @idea = Idea.find(params[:idea_id])
    @new_review = Review.new review_params
    @new_review.user = current_user
    @new_review.idea = @idea
    if @new_review.save
      flash[:alert] = "Review Created Succesfully"
      redirect_to @idea
    else
      @reviews = @idea.reviews.order(created_at: :desc)
      flash.now[:alert] = @new_review.errors.full_messages.join(", ").gsub("Body", "Review")
      render "ideas/show"
    end
  end

  def destroy
    @review = Review.find params[:id]
    @review.destroy
    flash[:alert] = "Review Deleted Succesfully"
    redirect_to @review.idea
  end

  private 

  def review_params 
    params.require(:review).permit(:body)
  end
end
