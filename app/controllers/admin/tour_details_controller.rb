# frozen_string_literal: true

class Admin::TourDetailsController < Admin::BaseController
  before_action :set_tour_detail_and_tour, only: %i[edit update destroy]

  def new
    @tour_detail = TourDetail.new
    @tour = Tour.find(params[:tour_id])
  end

  def create
    @tour = Tour.find(params[:tour_detail][:tour_id])
    @category = @tour.category
    @tour_detail = TourDetail.new(tour_detail_params)
    if @tour_detail.save
      flash[:success] = 'Time created!'
      redirect_to admin_category_tour_url(@category, @tour)
    else
      render 'new'
    end
  end

  def edit; end

  def update
    @category = @tour.category
    if @tour_detail.update(tour_detail_params)
      flash[:success] = 'Time updated!'
      redirect_to admin_category_tour_url(@category, @tour)
    else
      render 'edit'
    end
  end

  def destroy
    @category = @tour.category
    @tour_detail.destroy
    flash[:success] = 'Time deleted!'
    redirect_to admin_category_tour_url(@category, @tour)
  end

  private

  def tour_detail_params
    params.require(:tour_detail).permit(:tour_id, :departure_time, :return_time)
  end

  def set_tour_detail_and_tour
    @tour_detail = TourDetail.find(params[:id])
    @tour = @tour_detail.tour
  end
end
