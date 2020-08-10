class CommentsController < ApplicationController
  def create
    @review = Review.find(params[:review_id])
    @comment = current_user.comments.build(comment_params)
    @comment.review = @review
    if @comment.save
      flash[:success] = 'Comment created!'
      redirect_to category_tour_path(@review.tour.category, @review.tour)
    else
      @images = @tour.images
      @tour_details = @tour.tour_details
      @reviews = @tour.reviews.paginate(page: params[:page])
      render 'tours/show'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:success] = 'Comment deleted'
    redirect_to request.referrer || root_url
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
