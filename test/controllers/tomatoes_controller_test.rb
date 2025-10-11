require "test_helper"

class TomatoesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tomato = tomatoes(:one)
  end

  test "should get index" do
    get tomatoes_url
    assert_response :success
  end

  test "should get new" do
    get new_tomato_url
    assert_response :success
  end

  test "should create tomato" do
    assert_difference("Tomato.count") do
      post tomatoes_url, params: { tomato: { note: @tomato.note } }
    end

    assert_redirected_to tomato_url(Tomato.last)
  end

  test "should show tomato" do
    get tomato_url(@tomato)
    assert_response :success
  end

  test "should get edit" do
    get edit_tomato_url(@tomato)
    assert_response :success
  end

  test "should update tomato" do
    patch tomato_url(@tomato), params: { tomato: { note: @tomato.note } }
    assert_redirected_to tomato_url(@tomato)
  end

  test "should destroy tomato" do
    assert_difference("Tomato.count", -1) do
      delete tomato_url(@tomato)
    end

    assert_redirected_to tomatoes_url
  end
end
