require 'test_helper'

class Admin::GuestsControllerTest < ActionController::TestCase
  test "should create guest" do
    assert_difference('Guest.count') do
      post :create, {:guest => { last_name: 'Test' }}, {:guest_id => guests(:admin).id}
    end
    assert_redirected_to admin_guest_path(assigns(:guest))
  end

  test "should destroy guest" do
    assert_difference('Guest.count', -1) do
      delete :destroy, {:id => guests(:one).to_param}, {:guest_id => guests(:admin).id}
    end

    assert_redirected_to admin_guests_path
  end

  test "should get index" do
    get :index, nil, {:guest_id => guests(:admin).id}
    assert_response :success
    assert_not_nil assigns(:guests)
  end

  test "should get new" do
    get :new, nil, {:guest_id => guests(:admin).id}
    assert_response :success
  end

  test "should show guest" do
    get :show, {:id => guests(:one).to_param}, {:guest_id => guests(:admin).id}
    assert_response :success
  end

  test "should get edit" do
    get :edit, {:id => guests(:one).to_param}, {:guest_id => guests(:admin).id}
    assert_response :success
  end

  test "should update guest" do
    put :update, {:id => guests(:one).to_param, :guest => { }}, {:guest_id => guests(:admin).id}
    assert_redirected_to admin_guest_path(assigns(:guest))
  end

end
