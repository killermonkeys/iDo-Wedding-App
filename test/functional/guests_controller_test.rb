require 'test_helper'

class GuestsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:guests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should show guest" do
    get :show, :id => guests(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => guests(:one).to_param
    assert_response :success
  end

  test "should update guest" do
    put :update, :id => guests(:one).to_param, :guest => { }
    assert_redirected_to guest_path(assigns(:guest))
  end

end
