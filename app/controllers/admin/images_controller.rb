class Admin::ImagesController < Admin::BaseController
  before_action :set_tour

  def new
    @image = Image.new
  end

  def index
    @images = @tour.images
  end

  def create
  	if params[:image]
    	@image = @tour.images.build(link: params[:image][:link])
    	if @image.save
    		flash[:success] = 'Your image is uploaded!'
      	redirect_to admin_tour_images_path(@tour)
      else
      	render 'new'
      end
    else
    	flash.now[:danger] = 'You forgot to choose an image file!'
    	@image = Image.new
      render 'new'
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
