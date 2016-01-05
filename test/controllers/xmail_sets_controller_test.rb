require 'test_helper'

class XmailSetsControllerTest < ActionController::TestCase
  setup do
    @xmail_set = xmail_sets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:xmail_sets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create xmail_set" do
    assert_difference('XmailSet.count') do
      post :create, xmail_set: {name: @xmail_set.name, value: @xmail_set.value}
    end

    assert_redirected_to xmail_set_path(assigns(:xmail_set))
  end

  test "should show xmail_set" do
    get :show, id: @xmail_set
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @xmail_set
    assert_response :success
  end

  test "should update xmail_set" do
    patch :update, id: @xmail_set, xmail_set: {name: @xmail_set.name, value: @xmail_set.value}
    assert_redirected_to xmail_set_path(assigns(:xmail_set))
  end

  test "should destroy xmail_set" do
    assert_difference('XmailSet.count', -1) do
      delete :destroy, id: @xmail_set
    end

    assert_redirected_to xmail_sets_path
  end
end
