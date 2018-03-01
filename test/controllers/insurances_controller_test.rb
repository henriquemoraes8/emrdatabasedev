require 'test_helper'

class InsurancesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get insurances_create_url
    assert_response :success
  end

  test "should get login" do
    get insurances_login_url
    assert_response :success
  end

  test "should get records" do
    get insurances_records_url
    assert_response :success
  end

  test "should get records_by_clinic" do
    get insurances_records_by_clinic_url
    assert_response :success
  end

  test "should get search_users" do
    get insurances_search_users_url
    assert_response :success
  end

end
