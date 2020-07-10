class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'User deleted'
    redirect_to admin_users_url
  end
end
