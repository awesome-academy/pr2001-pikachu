# frozen_string_literal: true

class Search::ToursController < ApplicationController
  def index
    @tours = if params[:name].present?
               Tour.search_name(params[:name]).order_by_price(params[:sort_by_price].to_sym).find_by_category(params[:category_id]).paginate(page: params[:page], per_page: 9)
             else
               Tour.order_by_price(params[:sort_by_price].to_sym).find_by_category(params[:category_id]).paginate(page: params[:page], per_page: 9)
             end
  end
end
