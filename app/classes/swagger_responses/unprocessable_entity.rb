module SwaggerResponses
  module UnprocessableEntity
    def self.extended(base)
      base.response 422 do
        key :description, <<~HEREDOCS
          Unprocessable entity

          Example:
          ```json
          #{JSON.pretty_generate(errors: [{
            status: '422',
            title: 'First name can\'t be blank',
            source: { pointer: '/first_name' }
          }])}
          ```
        HEREDOCS
        schema type: :object, '$ref': :ApiErrorList
      end
    end
  end
end
