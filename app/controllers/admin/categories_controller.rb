# frozen_string_literal: true

class Admin::CategoriesController < Admin::BaseController
  before_action :set_category, only: %i[edit update destroy]

  def new
    @category = Category.new
  end

  def index
    @categories = Category.all
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      respond_to do |format|
        format.html { redirect_to admin_categories_url }
        format.js
      end
    else
      respond_to do |format|
        format.html { redirect_to admin_categories_url }
        format.js
      end
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      redirect_to admin_categories_path
      redirect_to admin_categories_url
    else
      render 'edit'
    end
  end

  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to admin_categories_url }
      format.js
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
