# frozen_string_literal: true

class ToursController < ApplicationController
  def index
    @category = Category.find(params[:category_id])
    @tours = @category.tours
  end

  def show
    @tour = Tour.find(params[:id])
    @images = @tour.images
    @tour_details = @tour.tour_details
    @booking_tour = BookingTour.new
    @booking_tours = current_user.booking_tours if current_user
  end
end
