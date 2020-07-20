# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :save_url, only: :new

  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

  private

  def save_url
    if params[:previous_url].present?
      session[:forwarding_url] = params[:previous_url]
    end
  end
end
