class UsersController < ApplicationController
  before_action :authenticate_admin_manager!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def admin
    @user = User.find(params[:id]).update(role: 'admin')
    redirect_to root_path
  end

end
