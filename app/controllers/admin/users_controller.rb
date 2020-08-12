# frozen_string_literal: true

class Admin::UsersController < Admin::BaseController
  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'User deleted'
    redirect_to admin_users_url
  end
end
