require 'test_helper'

class LocationsControllerTest < ActionController::TestCase

  setup do
    @location = Fabricate(:location)
    @user = Fabricate(:user)
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:locations)
    assert_select '#unexpected_error', false
    assert_template "locations/index"
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:location)
    assert_select '#unexpected_error', false
    assert_template "locations/new"
  end

  test "should create location" do
    assert_difference('Location.count') do
      post :create, location: Fabricate.attributes_for(:location)
    end

    assert_redirected_to location_url(assigns(:location))
  end

  test "should show location" do
    get :show, id: @location
    assert_response :success
    assert_not_nil assigns(:location)
    assert_select '#unexpected_error', false
    assert_template "locations/show"
  end

  test "should get edit" do
    get :edit, id: @location
    assert_response :success
    assert_not_nil assigns(:location)
    assert_select '#unexpected_error', false
    assert_template "locations/edit"
  end

  test "should update location" do
    put :update, id: @location, 
      location: Fabricate.attributes_for(:location, attr: 'value')
    assert_redirected_to location_url(assigns(:location))
  end

  test "should destroy location" do
    assert_difference('Location.count', -1) do
      delete :destroy, id: @location
    end

    assert_redirected_to locations_path
  end
end
