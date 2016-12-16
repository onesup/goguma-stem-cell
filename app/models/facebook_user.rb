class FacebookUser < User
  attr_accessor :auth_hash, :user

  def initialize(token)
    fb = OmniAuth::Strategies::Facebook.new(nil, Rails.application.secrets.omniauth_provider_key, Rails.application.secrets.omniauth_provider_secret)
    client = ::OAuth2::Client.new(Rails.application.secrets.omniauth_provider_key, Rails.application.secrets.omniauth_provider_secret, fb.options.client_options)
    token = OAuth2::AccessToken.new(client, token, fb.options.access_token_options)
    fb.access_token = token
    @auth_hash = fb.auth_hash
  rescue StandardError => e
    @auth_hash = e.code
  end

  def build_user
    if auth_hash['message'].present?
      return false
    else
      if User.exists?(email: auth_hash.info.email)
        user = User.where(email: auth_hash.info.email).last
      else
        user = User.new(name: auth_hash.info.name, email: auth_hash.info.email, provider: 'facebook')
        p = SecureRandom.urlsafe_base64(nil, false)
        user.password = p
        user.password_confirmation = p
      end
      user
    end
  end


end
