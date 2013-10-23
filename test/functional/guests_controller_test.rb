require 'test_helper'

class GuestsControllerTest < ActionController::TestCase
  
  test "should show guest" do
    get :show, {:id => guests(:two).to_param},  {:guest_id => guests(:two).id}
    assert_response :success
  end

  test "should get edit" do
    get :edit, {:id => guests(:two).to_param},  {:guest_id => guests(:two).id}
    assert_response :success
  end

  test "should not update guest if not authenticated" do
    put :update, :id => guests(:two).to_param, :guest => { last_name: 'Test'  }
    assert_redirected_to login_path
  end
  test "should update guest if authenticated" do
    put :update, {:id => guests(:two).to_param, :guest => { last_name: 'Test' }}, {:guest_id => guests(:two).id}
    assert_response :success
    assert_redirected_to guest_path(assigns(:guest))
  end

end
