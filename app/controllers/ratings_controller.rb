class RatingsController < ApplicationController
	def create
		@tour = Tour.find(params[:tour_id])
		@rating = current_user.ratings.build(rating_params)
		if @rating.save
			flash[:success] = 'Thank you for your rating!'
			redirect_to category_tour_url(@tour.category,@tour)
		else
			@images = @tour.images
			@tour_details = @tour.tour_details
			render 'tours/show'
		end
	end

	private
	def rating_params
		params.require(:rating).permit(:rate, :tour_id)
	end
end
