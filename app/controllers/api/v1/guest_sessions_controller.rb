module Api
  module V1
    class GuestSessionsController < Api::BaseController

      def create
        @resource = create_guest_user
        sign_in(:user, @resource, store: false, bypass: false)
        render_create_success
      end

      def resource_data(opts={})
        response_data = opts[:resource_json] || @resource.as_json
        if is_json_api
          response_data['type'] = @resource.class.name.parameterize
        end
        response_data
      end

      protected

      def is_json_api
        return false unless defined?(ActiveModel::Serializer)
        return ActiveModel::Serializer.setup do |config|
          config.adapter == :json_api
        end if ActiveModel::Serializer.respond_to?(:setup)
        return ActiveModelSerializers.config.adapter == :json_api
      end

      def render_create_success
        render json: {
          data: resource_data(resource_json: @resource.token_validation_response)
        }
      end

      private

      def create_guest_user
        @resource = User.create(:name => "guest", :email => "guest_#{Time.now.to_i}#{rand(100)}@example.com")

        @client_id = SecureRandom.urlsafe_base64(nil, false)
        @token     = SecureRandom.urlsafe_base64(nil, false)

        @resource.tokens[@client_id] = {
          token: BCrypt::Password.create(@token),
          expiry: (Time.now + DeviseTokenAuth.token_lifespan).to_i
        }
        @resource.save!(:validate => false)
        @resource
      end
    end
  end
end
