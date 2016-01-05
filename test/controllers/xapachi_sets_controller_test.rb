require 'test_helper'

class XapachiSetsControllerTest < ActionController::TestCase
  setup do
    @xapachi_set = xapachi_sets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:xapachi_sets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create xapachi_set" do
    assert_difference('XapachiSet.count') do
      post :create, xapachi_set: {name: @xapachi_set.name, value: @xapachi_set.value}
    end

    assert_redirected_to xapachi_set_path(assigns(:xapachi_set))
  end

  test "should show xapachi_set" do
    get :show, id: @xapachi_set
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @xapachi_set
    assert_response :success
  end

  test "should update xapachi_set" do
    patch :update, id: @xapachi_set, xapachi_set: {name: @xapachi_set.name, value: @xapachi_set.value}
    assert_redirected_to xapachi_set_path(assigns(:xapachi_set))
  end

  test "should destroy xapachi_set" do
    assert_difference('XapachiSet.count', -1) do
      delete :destroy, id: @xapachi_set
    end

    assert_redirected_to xapachi_sets_path
  end
end
