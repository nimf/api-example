module V1
  class ContactsController < ApplicationController
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

    # POST /v1/contacts
    def create
      @contact = Contact.new(contact_params)

      if @contact.save
        render json: @contact, status: :created,
               location: v1_contact_url(@contact)
      else
        render json: @contact.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /v1/contacts/1
    def update
      if @contact.update(contact_params)
        render json: @contact
      else
        render json: @contact.errors, status: :unprocessable_entity
      end
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
