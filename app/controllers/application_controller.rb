# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_categories
  include SessionsHelper

  def authorize_admin!
    unless current_user&.admin
      flash[:danger] = 'Please login!'
      redirect_to login_path
    end
  end

  def set_categories
    @categories = Category.all
  end
end
