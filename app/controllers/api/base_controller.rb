class Api::BaseController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken

  def authenticate_user!
    unless current_user

      return render json: { errors: ["사용자 인증이 필요합니다."] }, status: 401
    end
  end

end
