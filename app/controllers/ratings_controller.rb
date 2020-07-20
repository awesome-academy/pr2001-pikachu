class RatingsController < ApplicationController
  before_action :logged_in_user, only: :create
  
  def create
    @tour = Tour.find(params[:tour_id])
    @rating = current_user.ratings.build(rating_params)
    if @rating.save
      respond_to do |format|
        format.html do
        	flash[:danger] = "Thank you for your rating!"
        	redirect_to category_tour_url(@tour.category, @tour)
        end
        format.js
      end
    else
      respond_to do |format|
        format.html do
        	@tour_details = @tour.tour_details
        	@images = @tour.images
        	flash.now[:danger] = "Please rating again!"
        	render 'tours/show'
        end
        format.js
      end
    end
  end

  private

  def rating_params
    params.require(:rating).permit(:rate, :tour_id)
  end
end
