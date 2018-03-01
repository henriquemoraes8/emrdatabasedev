require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get users_create_url
    assert_response :success
  end

  test "should get login" do
    get users_login_url
    assert_response :success
  end

  test "should get records" do
    get users_records_url
    assert_response :success
  end

  test "should get records_by_clinic" do
    get users_records_by_clinic_url
    assert_response :success
  end

  test "should get validate" do
    get users_validate_url
    assert_response :success
  end

end
