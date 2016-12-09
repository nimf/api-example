class ApiError < StandardError
  attr_reader :status, :detail

  def initialize(msg = 'Internal Error', status = '500', detail = nil)
    @status = status
    @detail = detail
    super(msg)
  end

  def serialized
    {
      status: status,
      title: message,
      detail: detail
    }
  end

  include Swagger::Blocks

  swagger_schema :ApiErrorList, required: [:errors] do
    property :errors, type: :array, minItems: 1 do
      items '$ref' => :ApiError
    end
  end

  swagger_schema :ApiError do
    key :required, [:status, :title]
    property :id, type: :string,
                  example: '08ad0f85-b67f-4259-8c43-51deac75ba45',
                  description:
      'a unique identifier for this particular occurrence of the problem'
    property :status, type: :string, example: '500',
                      description:
      'the HTTP status code applicable to this problem, '\
      'expressed as a string value'
    property :title, type: :string, example: 'Internal server error',
                     description: 'summary of the problem'
    property :detail, type: :string,
                      example: 'Oops! Something went wrong. Please try again',
                      description:
      'explanation specific to this occurrence of the problem'
    property :meta, type: :object, description:
      'a meta object containing non-standard meta-information about the error'
    property :source, type: :object, title: :ApiErrorSource do
      property :pointer, type: :string, example: '/field_name',
                         description:
        'a JSON Pointer [RFC6901] to the associated entity '\
        'in the request document'
      property :parameter, type: :string, example: 'field_name',
                           description:
        'a string indicating which URI query parameter caused the error'
    end
  end
end
