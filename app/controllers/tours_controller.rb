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
    @ratings = Rating.all
    @tour_details = @tour.tour_details
    @booking_tours = current_user.booking_tours if current_user
    @reviews = @tour.reviews.paginate(page: params[:page])
    @review = Review.new
    @comment = Comment.new
  end
end
