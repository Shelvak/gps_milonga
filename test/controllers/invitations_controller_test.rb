require 'test_helper'

class InvitationsControllerTest < ActionController::TestCase

  setup do
    @invitation = Fabricate(:invitation)
    @user = Fabricate(:user)
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:invitations)
    assert_select '#unexpected_error', false
    assert_template "invitations/index"
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:invitation)
    assert_select '#unexpected_error', false
    assert_template "invitations/new"
  end

  test "should create invitation" do
    assert_difference('Invitation.count') do
      post :create, invitation: Fabricate.attributes_for(:invitation)
    end

    assert_redirected_to invitation_url(assigns(:invitation))
  end

  test "should show invitation" do
    get :show, id: @invitation
    assert_response :success
    assert_not_nil assigns(:invitation)
    assert_select '#unexpected_error', false
    assert_template "invitations/show"
  end

  test "should get edit" do
    get :edit, id: @invitation
    assert_response :success
    assert_not_nil assigns(:invitation)
    assert_select '#unexpected_error', false
    assert_template "invitations/edit"
  end

  test "should update invitation" do
    put :update, id: @invitation, 
      invitation: Fabricate.attributes_for(:invitation, attr: 'value')
    assert_redirected_to invitation_url(assigns(:invitation))
  end

  test "should destroy invitation" do
    assert_difference('Invitation.count', -1) do
      delete :destroy, id: @invitation
    end

    assert_redirected_to invitations_path
  end
end
