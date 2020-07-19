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
        respond_to do |format|
          format.html { redirect_to admin_tour_images_path(@tour) }
          format.js
        end
      else
        respond_to do |format|
          format.html { redirect_to admin_tour_images_path(@tour) }
          format.js
        end
      end
    else
      @image = @tour.images.build
      @image.valid?
      respond_to do |format|
        format.html { redirect_to admin_tour_images_path(@tour) }
        format.js
      end
    end
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy
    respond_to do |format|
      format.html { redirect_to admin_tour_images_path(@tour) }
      format.js
    end
  end

  private

  def set_tour
    @tour = Tour.find(params[:tour_id])
  end
end
