class ApplicationController < ActionController::Base
  protect_from_forgery unless: -> { request.format.json? }
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :current_manager
  helper_method :manager_signed_in?
  helper_method :correct_manager?

  private

    def current_manager
      begin
        @current_manager ||= User.find(session[:user_id]) if session[:user_id]
      rescue Exception => e
        nil
      end
    end

    def manager_signed_in?
      return true if current_manager
    end

    def correct_manager?
      @user = User.find(params[:id])
      unless current_manager == @user
        redirect_to root_url, :alert => "Access denied."
      end
    end

    def authenticate_manager!
      if !current_manager
        redirect_to root_url, :alert => 'You need to sign in for access to this page.'
      end
    end

    def authenticate_admin_manager!
      if !current_manager || !current_manager.admin?
        redirect_to root_url, :alert => '잘못된 접근입니다.'
      end
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
    end

end
