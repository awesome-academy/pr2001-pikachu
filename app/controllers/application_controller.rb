# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionsHelper

  def authorize_admin!
    unless current_user.admin
      flash[:danger] = 'Please login'
      redirect_to root_url
    end
  end
end
