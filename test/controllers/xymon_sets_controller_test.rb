require 'test_helper'

class XymonSetsControllerTest < ActionController::TestCase
  setup do
    @xymon_set = xymon_sets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:xymon_sets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create xymon_set" do
    assert_difference('XymonSet.count') do
      post :create, xymon_set: {name: @xymon_set.name, value: @xymon_set.value}
    end

    assert_redirected_to xymon_set_path(assigns(:xymon_set))
  end

  test "should show xymon_set" do
    get :show, id: @xymon_set
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @xymon_set
    assert_response :success
  end

  test "should update xymon_set" do
    patch :update, id: @xymon_set, xymon_set: {name: @xymon_set.name, value: @xymon_set.value}
    assert_redirected_to xymon_set_path(assigns(:xymon_set))
  end

  test "should destroy xymon_set" do
    assert_difference('XymonSet.count', -1) do
      delete :destroy, id: @xymon_set
    end

    assert_redirected_to xymon_sets_path
  end
end
