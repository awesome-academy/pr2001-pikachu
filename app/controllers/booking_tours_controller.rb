# frozen_string_literal: true

class BookingToursController < ApplicationController
  def new
    @booking_tour = BookingTour.new
    @tour = Tour.find(params[:tour_id])
  end

  def create
    @tour = Tour.find(params[:tour_id])
    @booking_tour = current_user.booking_tours.build(booking_tour_params)
    @booking_tour.price_total = booking_tour_params[:quantity].to_i *
                                @tour.price
    if @booking_tour.save
      flash[:success] = 'You booked tour successful!'
      redirect_to category_tour_path(@tour.category_id, @tour)
    else
      render 'new'
    end
  end

  private

  def booking_tour_params
    params.require(:booking_tour).permit(:tour_detail_id, :user_id, :quantity,
                                         :price_total)
end
end
