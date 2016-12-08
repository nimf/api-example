require 'test_helper'

class ContactsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @contact = contacts(:one)
  end

  test "should get index" do
    get v1_contacts_url, as: :json
    assert_response :success
  end

  test "should create contact" do
    assert_difference('Contact.count') do
      post v1_contacts_url, params: { contact: { first_name: @contact.first_name, last_name: @contact.last_name, phone: @contact.phone } }, as: :json
    end

    assert_response 201
  end

  test "should show contact" do
    get v1_contact_url(@contact), as: :json
    assert_response :success
  end

  test "should update contact" do
    patch v1_contact_url(@contact), params: { contact: { first_name: @contact.first_name, last_name: @contact.last_name, phone: @contact.phone } }, as: :json
    assert_response 200
  end

  test "should destroy contact" do
    assert_difference('Contact.count', -1) do
      delete v1_contact_url(@contact), as: :json
    end

    assert_response 204
  end
end
