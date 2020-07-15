# frozen_string_literal: true

class BookingToursController < ApplicationController
  before_action :logged_in_user, only: :create
  def create
    @tour = Tour.find(params[:tour_id])
    @booking_tour = current_user.booking_tours.build(booking_params)
    @booking_tour.price_total = params[:booking_tour][:quantity].to_i *
                                @tour.price
    if @booking_tour.save
      flash[:success] = 'Your booking is successful!'
      redirect_to tour_booking_tour_path(@tour, @booking_tour)
    else
      flash[:danger] = 'Your booking is failed!'
      @tour_details = @tour.tour_details
      @images = @tour.images
      render 'tours/show'
    end
  end

  def show
    @booking_tour = BookingTour.find(params[:id])
    @tour = @booking_tour.tour_detail.tour
  end

  def edit; end

  def update; end

  def destroy; end

  private
  def booking_params
    params.require(:booking_tour).permit(:tour_detail_id, :quantity, :price_total)
  end
end
