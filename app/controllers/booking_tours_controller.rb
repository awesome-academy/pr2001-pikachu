# frozen_string_literal: true

class BookingToursController < ApplicationController
  before_action :logged_in_user, only: %i[new create]

  def new
    @booking_tour = BookingTour.new
    @tour = Tour.find(params[:tour_id])
    @tour_detail = TourDetail.find(params[:tour_detail_id])
  end

  def create
    if params[:bill]
      @booking_tour = BookingTour.find(params[:booking_tour_id])
      check_coin @booking_tour
    else
      @tour = Tour.find(params[:tour_id])
      @booking_tour = current_user.booking_tours.build(booking_params)
      @booking_tour.price_total = params[:booking_tour][:quantity].to_i *
                                  @tour.price * (1 - @tour.coupon / 100.to_f)
      if @booking_tour.save
        flash[:success] = 'Your booking is successful!'
        redirect_to tour_booking_tour_path(@tour, @booking_tour)
      else
        flash.now[:danger] = 'Your booking is failed!'
        @tour_detail = TourDetail.find(params[:booking_tour][:tour_detail_id])
        render 'new'
      end
    end
  end

  def show
    @booking_tour = BookingTour.find(params[:id])
    @tour = @booking_tour.tour_detail.tour
  end

  def update
    @booking_tour = BookingTour.find(params[:id])
    @tour = Tour.find(params[:tour_id])
    check_to_cancel(@booking_tour, @tour) if @booking_tour.pay?
    @booking_tour.cancel!
    @booking_tour.unpay!
    flash[:success] = 'Cancel successful!'
    redirect_to category_tour_path(@tour.category, @tour)
  end

  private

  def booking_params
    params.require(:booking_tour).permit(:tour_detail_id, :quantity, :price_total)
  end

  def check_to_cancel(booking_tour, tour)
    different_date = booking_tour.tour_detail.departure_time - Time.zone.today
    paid_coin =
      if different_date >= 7
        params[:bill].to_i
      elsif different_date >= 5
        (params[:bill].to_i * 0.5).to_i
      elsif different_date >= 3
        (params[:bill].to_i * 0.1).to_i
      else
        0
      end
    current_user.update(coin: current_user.coin + paid_coin) if paid_coin > 0
    Payment.cancel.create(user_id: current_user.id.to_s,
                   coin: paid_coin, tour_id: tour.id)
  end
end
