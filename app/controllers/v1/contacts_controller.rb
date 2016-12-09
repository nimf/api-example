module V1
  class ContactsController < ApiController
    before_action :set_contact, only: [:show, :update, :destroy]

    include Swagger::Blocks

    swagger_schema :ContactsList do
      property :contacts, type: :array do
        items '$ref' => :Contact
      end
    end

    swagger_path '/contacts' do
      operation :get do
        key :summary, 'Returns contacts'
        key :description, ''
        key :operationId, 'getContacts'
        key :tags, ['contact']
        key :produces, ['application/json']
        response 200 do
          key :description, 'Successful response - list of contacts'
          schema type: :object, '$ref': :ContactsList
        end
      end
    end
    # GET /v1/contacts
    def index
      @contacts = Contact.all

      render json: @contacts
    end

    # GET /v1/contacts/1
    def show
      render json: @contact
    end

    swagger_schema :ContactInput do
      key :required, [:first_name, :last_name, :phone]
      property :first_name, type: :string, example: 'Yuriy'
      property :last_name, type: :string, example: 'Golobokov'
      property :phone, type: :string, example: '+77012111189'
    end

    swagger_schema :SingleContact do
      property :contact, '$ref' => :Contact
    end

    swagger_path '/contacts' do
      operation :post do
        key :summary, 'Creates new contact'
        key :description, ''
        key :operationId, 'createContact'
        key :tags, ['contact']
        key :consumes, ['application/json']
        key :produces, ['application/json']
        parameter name: :contact, in: :body, required: true do
          schema '$ref' => :ContactInput
        end
        response 201 do
          key :description, 'Successful response - newly created contact'
          schema type: :object, '$ref': :SingleContact
        end
        extend SwaggerResponses::UnprocessableEntity
      end
    end
    # POST /v1/contacts
    def create
      @contact = Contact.new(contact_params)
      @contact.save!
      render json: @contact, status: :created,
             location: v1_contact_url(@contact)
    end

    # PATCH/PUT /v1/contacts/1
    def update
      @contact.update!(contact_params)
      render json: @contact
    end

    # DELETE /v1/contacts/1
    def destroy
      @contact.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_contact
        @contact = Contact.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def contact_params
        params.require(:contact).permit(:first_name, :last_name, :phone)
      end
  end
end
