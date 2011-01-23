require 'test_helper'

class WellsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:wells)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create well" do
    assert_difference('Well.count') do
      post :create, :well => { }
    end

    assert_redirected_to well_path(assigns(:well))
  end

  test "should show well" do
    get :show, :id => wells(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => wells(:one).id
    assert_response :success
  end

  test "should update well" do
    put :update, :id => wells(:one).id, :well => { }
    assert_redirected_to well_path(assigns(:well))
  end

  test "should destroy well" do
    assert_difference('Well.count', -1) do
      delete :destroy, :id => wells(:one).id
    end

    assert_redirected_to wells_path
  end
end
