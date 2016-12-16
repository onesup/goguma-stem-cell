class PasswordResetRequestsController < ApplicationController
  before_action :set_user_by_token, only: [:new]

  def new
    @resource
    render layout: false
  end

  def update
    @resource = User.find params[:id]
    @resource.reset_password(params[:user][:password], params[:user][:password_confirmation])
    session[:user_id] = @resource.id.to_s
    redirect_to password_reset_request_path(@resource)
  end

  def show
    if session[:user_id] == params[:id]
      @resource = User.find params[:id]
      render layout: false
    else
      redirect_to root_path, status: 401, alert: '사용자 인증이 필요합니다.'
    end
  end

  protected

  def set_user_by_token
    uid        = params[:uid]
    @token     = params[:token]
    @client_id = params[:client_id]
    user = uid && User.find_by_uid(uid)
    if user && user.valid_token?(@token, @client_id)
      # sign_in with bypass: true will be deprecated in the next version of Devise
      if self.respond_to? :bypass_sign_in
        bypass_sign_in(user, scope: :user)
      else
        sign_in(:user, user, store: false, bypass: true)
      end
      return @resource = user
    else
      # zero all values previously set values
      @client_id = nil
      return @resource = nil
    end
  end

end
