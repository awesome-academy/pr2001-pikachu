# frozen_string_literal: true

class Admin::StaticPagesController < Admin::BaseController
  def home_admin
    @bookings = BookingTour.book
    @cancels = BookingTour.cancel
    @paids = BookingTour.pay
    @payment_naps = Payment.nap
    @payment_bookings = Payment.book
    @payment_cancels = Payment.cancel

    # Tours co nhieu lan dat nhat
    tour_detail = TourDetail.joins(:booking_tours)
                            .merge(BookingTour.pay).group(:tour_id).count
    @count =  tour_detail.values.max
    @best_salers = Tour.where(id: tour_detail.select { |k, v| v == @count }.keys) 
    @coin_totals = @best_salers.map do |best_saler|
      BookingTour.pay.joins(:tour_detail).where(tour_detail: best_saler.tour_details)
                 .map { |booking_tour| booking_tour.price_total.to_i }.sum
    end
    @hash = @best_salers.zip(@coin_totals).to_h

    # Tours have best Rating Average
    tour = Tour.joins(:ratings).group(:tour_id).count.keys
    @best_ratings = Tour.where(id: tour)
                        .map { |x| (x.ratings.sum { |y| y.rate }) / x.ratings.count.to_f }
    @hash_ratings = tour.zip(@best_ratings).to_h
                        .select { |k, v| v == tour.zip(@best_ratings).to_h.values.max }
  end
end
