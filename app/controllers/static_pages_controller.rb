# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    @tours = Tour.all
  end

  def help; end
end
