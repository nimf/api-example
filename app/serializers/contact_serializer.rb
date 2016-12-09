class ContactSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :phone

  include Swagger::Blocks

  swagger_schema :Contact do
    key :required, [:id, :first_name, :last_name, :phone]
    property :id, type: :integer, format: :int32, example: '1'
    property :first_name, type: :string, example: 'Yuriy'
    property :last_name, type: :string, example: 'Golobokov'
    property :phone, type: :string, example: '+77012111189'
  end
end
