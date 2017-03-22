require 'test_helper'

class ContatosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @contato = contatos(:one)
    @page = pages(:one)
  end

  test "should get index" do
    get contatos_url, as: :json
    assert_response :success
  end

  test "should create one contato and one page" do
    Contato.delete_all
    assert_difference('Contato.count', 1) do
      post contatos_url, params: { contato: { email: @contato.email }, pages:[@page] }, as: :json
    end

    assert_response 201
  end

  test "should insert 1 user and 3 pages" do
    assert_difference('Contato.count', 1) do
      post contatos_url, params: { contato: { email: 'a@a' }, pages:[{url:'a'},{url:'b'},{url:'c'}] }, as: :json
    end
    assert_equal(Contato.last.id, response.parsed_body["id"])
    assert_equal(Contato.last.pages.count, 3)
  end

  test "should not create entity without pages" do
    post contatos_url, params: { contato: @contato}, as: :json
    assert_response :unprocessable_entity
  end

  test "should show contato" do
    get contato_url(@contato), as: :json
    assert_response :success
  end

  test "should update contato" do
    patch contato_url(@contato), params: { contato: { email: @contato.email } }, as: :json
    assert_response 200
  end

  test "should destroy contato" do
    assert_difference('Contato.count', -1) do
      delete contato_url(@contato), as: :json
    end

    assert_response 204
  end
end
