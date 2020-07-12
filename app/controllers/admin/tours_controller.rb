# frozen_string_literal: true

class Admin::ToursController < Admin::BaseController
  before_action :set_category, except: :show
  before_action :set_tour, except: %i[index new create]

  def index
    @tours = @category.tours
  end

  def show
    @tour_details = @tour.tour_details
    @category = @tour.category
  end

  def new
    @tour = Tour.new
  end

  def create
    @tour = @category.tours.build(tour_params)
    if @tour.save
      flash[:success] = 'Tour created!'
      redirect_to admin_category_tours_url(@category)
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @tour.update(tour_params)
      flash[:success] = 'Tour updated!'
      redirect_to admin_category_tours_url(@category)
    else
      render 'edit'
    end
  end

  def destroy
    @tour.destroy
    flash[:success] = 'Tour deleted!'
    redirect_to admin_category_tours_url(@category)
  end

  private

  def tour_params
    params.require(:tour).permit(:name, :description, :price, :coupon,
                                 :seats, images_attributes: %i[link id])
  end

  def set_category
    @category = Category.find(params[:category_id])
  end

  def set_tour
    @tour = Tour.find(params[:id])
  end
end
