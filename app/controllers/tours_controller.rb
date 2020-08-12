# frozen_string_literal: true

class ToursController < ApplicationController
  def index
    @category = Category.find(params[:category_id])
    @tours = @category.tours
  end

  def show
    @tour = Tour.find(params[:id])
    @images = @tour.images
    @rating = Rating.new
    @tour_details = @tour.tour_details
    @reviews = @tour.reviews.paginate(page: params[:page])
    @review = Review.new
    @comment = Comment.new
    @reviews_likes = current_user.likes.where(likeable_type: "Review")
    @comments_likes = current_user.likes.where(likeable_type: "Comment")
  end
end
