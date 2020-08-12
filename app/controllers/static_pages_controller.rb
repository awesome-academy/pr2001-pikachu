# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    @tours = Tour.paginate(page: params[:page], per_page: 9)
  end

  def help; end
end
