class Admin::BookingToursController < Admin::BaseController
  def index
    @booking_tours = BookingTour.paginate(page: params[:page], per_page: 8)
  end
end
