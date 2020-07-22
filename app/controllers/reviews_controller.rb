class ReviewsController < ApplicationController
  before_action :logged_in_user, only: %i[create destroy]
  before_action :correct_user, only: :destroy

  def create
    @tour = Tour.find(params[:tour_id])
    @review = current_user.reviews.build(review_params)
    @review.tour = @tour
    if @review.save
      flash[:success] = 'Review created!'
      redirect_to category_tour_path(@tour.category, @tour)
    else
      @images = @tour.images
      @tour_details = @tour.tour_details
      @reviews = @tour.reviews.paginate(page: params[:page])
      render 'tours/show'
    end
  end

  def destroy
    @review.destroy
    flash[:success] = 'Review deleted'
    redirect_to request.referrer || root_url
  end

  private

  def review_params
    params.require(:review).permit(:content, :picture)
  end

  def correct_user
    @review = current_user.reviews.find_by(id: params[:id])
    redirect_to root_url if @review.nil?
end
end
