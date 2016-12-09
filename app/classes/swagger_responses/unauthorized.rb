module SwaggerResponses
  module Unauthorized
    def self.extended(base)
      base.response 401 do
        key :description, <<~HEREDOCS
          Unauthorized

          Example:
          ```json
          #{JSON.pretty_generate(errors: [{
            status: '401',
            title: 'Unauthorized'
          }])}
          ```
        HEREDOCS
        schema type: :object, '$ref': :ApiErrorList
      end
    end
  end
end
