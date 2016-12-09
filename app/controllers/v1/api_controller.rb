module V1
  class ApiController < ApplicationController
    include ActionController::HttpAuthentication::Token::ControllerMethods

    before_action :authenticate

    rescue_from ActiveRecord::RecordInvalid do |exception|
      errors = exception.record.errors.messages.each_key.map do |param|
        {
          status: '422',
          title: exception.record.errors.full_messages_for(param).join("\n"),
          source: { pointer: "/#{param}"}
        }
      end
      render json: { errors: errors }, status: 422
    end

    private

    def authenticate
      authenticate_token || render_unauthorized
    end

    def authenticate_token
      authenticate_with_http_token do |token, _options|
        # @current_user = AuthToken.find_by(token: token)&.user
        token == 'abc123'
      end
    end

    def render_unauthorized(realm = "Phonebook API")
      headers["WWW-Authenticate"] = %(Token realm="#{realm.delete('"')}")
      render json: { errors: [ApiError.new('Unauthorized', '401').serialized] },
             status: :unauthorized
    end
  end
end
