require 'test_helper'

class NetworkSetsControllerTest < ActionController::TestCase
  setup do
    @network_set = network_sets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:network_sets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create network_set" do
    assert_difference('NetworkSet.count') do
      post :create, network_set: {address: @network_set.address, broadcast: @network_set.broadcast, gateway: @network_set.gateway, hostname: @network_set.hostname, netmask: @network_set.netmask, network: @network_set.network}
    end

    assert_redirected_to network_set_path(assigns(:network_set))
  end

  test "should show network_set" do
    get :show, id: @network_set
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @network_set
    assert_response :success
  end

  test "should update network_set" do
    patch :update, id: @network_set, network_set: {address: @network_set.address, broadcast: @network_set.broadcast, gateway: @network_set.gateway, hostname: @network_set.hostname, netmask: @network_set.netmask, network: @network_set.network}
    assert_redirected_to network_set_path(assigns(:network_set))
  end

  test "should destroy network_set" do
    assert_difference('NetworkSet.count', -1) do
      delete :destroy, id: @network_set
    end

    assert_redirected_to network_sets_path
  end
end
