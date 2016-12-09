module V1
  class ApiController < ApplicationController

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

  end
end
