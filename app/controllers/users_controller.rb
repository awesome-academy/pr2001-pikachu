# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[index edit update]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = 'Welcome to the Sample App!'
      redirect_to @user
    else
      render 'new'
    end
   end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if params[:user][:coin] # user nap coin --> TODO
      @user.update(coin: params[:user][:coin].to_i + @user.coin)
      @payment = Payment.create(user_id: @user.id.to_s, status: 2, coin: params[:user][:coin])
      redirect_back_or @user
    else
      if @user.update(user_params)
        flash[:success] = 'Profile updated'
        redirect_to @user
      else
        render 'edit'
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
   end
end
