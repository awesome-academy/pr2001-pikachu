# frozen_string_literal: true

class BookingToursController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]
  before_action :check_to_cancel, only: :destroy

  def new
  	@booking_tour = BookingTour.new
  	@tour = Tour.find(params[:tour_id])
  	@tour_detail = TourDetail.find(params[:tour_detail_id])	
  end

  def create
    @tour = Tour.find(params[:tour_id])
    @booking_tour = current_user.booking_tours.build(booking_params)
    @booking_tour.price_total = params[:booking_tour][:quantity].to_i *
                                @tour.price * (1 - @tour.coupon/100.to_f)
    if @booking_tour.save
      flash[:success] = 'Your booking is successful!'
      redirect_to tour_booking_tour_path(@tour, @booking_tour)
    else
      flash.now[:danger] = 'Your booking is failed!'
      @tour_detail = TourDetail.find(params[:booking_tour][:tour_detail_id])
      render 'new'	
    end
  end

  def show
    @booking_tour = BookingTour.find(params[:id])
    @tour = @booking_tour.tour_detail.tour
  end

  def destroy
  	@booking_tour.destroy
  	flash[:success] = "Cancel successful!"
  	redirect_to category_tour_path(@tour.category, @tour)
  end

  private
  def booking_params
    params.require(:booking_tour).permit(:tour_detail_id, :quantity, :price_total)
  end

  def check_to_cancel
  	@booking_tour = BookingTour.find(params[:id])
  	@tour = Tour.find(params[:tour_id])
  	if @booking_tour.tour_detail.departure_time - Time.zone.today < 7
  		redirect_to tour_booking_tour_path(@tour, @booking_tour)
  		flash[:danger] = 'Cancel time must be at least 7 days early than departime time!'
  	end
  end

end
