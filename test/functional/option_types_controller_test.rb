require 'test_helper'

class Admin::OptionTypesControllerTest < ActionController::TestCase
  setup do
    @admin_option_type = admin_option_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_option_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_option_type" do
    assert_difference('Admin::OptionType.count') do
      post :create, admin_option_type: {  }
    end

    assert_redirected_to admin_option_type_path(assigns(:admin_option_type))
  end

  test "should show admin_option_type" do
    get :show, id: @admin_option_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_option_type
    assert_response :success
  end

  test "should update admin_option_type" do
    put :update, id: @admin_option_type, admin_option_type: {  }
    assert_redirected_to admin_option_type_path(assigns(:admin_option_type))
  end

  test "should destroy admin_option_type" do
    assert_difference('Admin::OptionType.count', -1) do
      delete :destroy, id: @admin_option_type
    end

    assert_redirected_to admin_option_types_path
  end
end
