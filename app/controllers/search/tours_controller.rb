# frozen_string_literal: true

class Search::ToursController < ApplicationController
  def index
    @tours = if params[:name].present?
               Tour.search_name(params[:name]).order_by_created_at(params[:sort_by_created_at].to_sym)
             else
               Tour.none
             end
  end
end
