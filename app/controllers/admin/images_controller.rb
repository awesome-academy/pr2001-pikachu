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
          format.html do
            flash[:success] = 'Your image is upload!'
            redirect_to admin_tour_images_path(@tour)
          end
          format.js
        end
      else
        respond_to do |format|
          format.html do
            flash[:danger] = 'Upload is failed!'
            redirect_to admin_tour_images_path(@tour)
          end
          format.js
        end
      end
    else
      @image = @tour.images.build
      @image.valid?
      respond_to do |format|
        format.html do
          flash[:danger] = 'Upload is failed!'
          redirect_to admin_tour_images_path(@tour)
        end
        format.js
      end
    end
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy
    respond_to do |format|
      format.html do
        flash[:success] = 'Your image is deleted!'
        redirect_to admin_tour_images_path(@tour)
      end
      format.js
    end
  end

  private

  def set_tour
    @tour = Tour.find(params[:tour_id])
  end
end
