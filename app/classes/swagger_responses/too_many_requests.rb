module SwaggerResponses
  module TooManyRequests
    def self.extended(base)
      base.response 429 do
        key :description, <<~HEREDOCS
          Too many requests

          Example:
          ```json
          #{JSON.pretty_generate(errors: [{
            status: '429',
            title: 'Throttle limit reached',
            detail: 'Retry in 5 seconds'
          }])}
          ```
        HEREDOCS
        schema type: :object, '$ref': :ApiErrorList
      end
    end
  end
end
