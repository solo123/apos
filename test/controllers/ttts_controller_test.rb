require 'test_helper'

class TttsControllerTest < ActionController::TestCase
  setup do
    @ttt = ttts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ttts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ttt" do
    assert_difference('Ttt.count') do
      post :create, ttt: { level: @ttt.level, name: @ttt.name }
    end

    assert_redirected_to ttt_path(assigns(:ttt))
  end

  test "should show ttt" do
    get :show, id: @ttt
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ttt
    assert_response :success
  end

  test "should update ttt" do
    patch :update, id: @ttt, ttt: { level: @ttt.level, name: @ttt.name }
    assert_redirected_to ttt_path(assigns(:ttt))
  end

  test "should destroy ttt" do
    assert_difference('Ttt.count', -1) do
      delete :destroy, id: @ttt
    end

    assert_redirected_to ttts_path
  end
end
