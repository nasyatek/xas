require 'test_helper'

class XasSetsControllerTest < ActionController::TestCase
  setup do
    @xas_set = xas_sets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:xas_sets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create xas_set" do
    assert_difference('XasSet.count') do
      post :create, xas_set: {name: @xas_set.name, value: @xas_set.value}
    end

    assert_redirected_to xas_set_path(assigns(:xas_set))
  end

  test "should show xas_set" do
    get :show, id: @xas_set
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @xas_set
    assert_response :success
  end

  test "should update xas_set" do
    patch :update, id: @xas_set, xas_set: {name: @xas_set.name, value: @xas_set.value}
    assert_redirected_to xas_set_path(assigns(:xas_set))
  end

  test "should destroy xas_set" do
    assert_difference('XasSet.count', -1) do
      delete :destroy, id: @xas_set
    end

    assert_redirected_to xas_sets_path
  end
end
