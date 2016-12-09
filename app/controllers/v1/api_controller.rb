module V1
  class ApiController < ApplicationController
    include ActionController::HttpAuthentication::Token::ControllerMethods

    before_action :set_locale
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

    def set_locale
      accept_language = request.env['HTTP_ACCEPT_LANGUAGE']&.scan(/^[a-z]{2}/)
                                                           &.first&.to_sym
      I18n.locale = accept_language if I18n.available_locales
                                           .include? accept_language
    end

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
