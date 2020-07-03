# frozen_string_literal: true

class Admin::CategoriesController < Admin::BaseController
  before_action :set_category, only: %i[edit update destroy]

  def new
    @category = Category.new
  end

  def index
    @categories = Category.all
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = 'Category created!'
      redirect_to admin_categories_url
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      flash[:success] = 'Category updated!'
      redirect_to admin_categories_path
    else
      render 'edit'
    end
  end

  def destroy
    @category.destroy
    flash[:success] = 'Category deleted!'
    redirect_to admin_categories_url
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
