# frozen_string_literal: true

class Admin::ImagesController < Admin::BaseController
  before_action :set_tour

  def index
    @images = @tour.images
    @image = Image.new
  end

  def create
    if params[:image]
      @image = @tour.images.build(link: params[:image][:link])
      if @image.save
        flash[:success] = 'Your image is uploaded!'
        redirect_to admin_tour_images_path(@tour)
      else
      	@images = @tour.images
        render 'index'
      end
    else
      flash.now[:danger] = 'You forgot to choose an image file!'
      @image = Image.new
      @images = @tour.images
      render 'index'
    end
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy
    flash[:success] = 'Your image is deleted!'
    redirect_to admin_tour_images_path(@tour)
  end

  private
  def set_tour
    @tour = Tour.find(params[:tour_id])
  end
end
