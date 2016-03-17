require 'test_helper'

class GroupsControllerTest < ActionController::TestCase

  setup do
    @group = Fabricate(:group)
    @user = Fabricate(:user)
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:groups)
    assert_select '#unexpected_error', false
    assert_template "groups/index"
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:group)
    assert_select '#unexpected_error', false
    assert_template "groups/new"
  end

  test "should create group" do
    assert_difference('Group.count') do
      post :create, group: Fabricate.attributes_for(:group)
    end

    assert_redirected_to group_url(assigns(:group))
  end

  test "should show group" do
    get :show, id: @group
    assert_response :success
    assert_not_nil assigns(:group)
    assert_select '#unexpected_error', false
    assert_template "groups/show"
  end

  test "should get edit" do
    get :edit, id: @group
    assert_response :success
    assert_not_nil assigns(:group)
    assert_select '#unexpected_error', false
    assert_template "groups/edit"
  end

  test "should update group" do
    put :update, id: @group, 
      group: Fabricate.attributes_for(:group, attr: 'value')
    assert_redirected_to group_url(assigns(:group))
  end

  test "should destroy group" do
    assert_difference('Group.count', -1) do
      delete :destroy, id: @group
    end

    assert_redirected_to groups_path
  end
end
