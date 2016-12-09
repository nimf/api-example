module V1
  class ApidocsController < ActionController::Base
    include Swagger::Blocks

    swagger_root do
      key :swagger, '2.0'
      info do
        key :version, '1.0.0'
        key :title, 'Phonebook API'
        key :description, <<~HEREDOCS
          You can use this API to store and read contacts information
        HEREDOCS
        key :termsOfService, 'http://localhost:3000/terms/'
        contact do
          key :name, 'OpenIT API Team'
        end
        license do
          key :name, 'MIT'
        end
      end
      tag do
        key :name, 'contact'
        key :description, 'Contacts operations'
        externalDocs do
          key :description, 'Find more info here'
          key :url, 'https://swagger.io'
        end
      end
      key :host, 'localhost:3000'
      key :basePath, '/v1'
      key :consumes, ['application/json']
      key :produces, ['application/json']
    end

    # A list of all classes that have swagger_* declarations.
    SWAGGERED_CLASSES = [
      self
    ].freeze

    def index
      render json: Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
    end
  end
end
