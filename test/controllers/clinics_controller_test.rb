require 'test_helper'

class ClinicsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get clinics_create_url
    assert_response :success
  end

  test "should get login" do
    get clinics_login_url
    assert_response :success
  end

  test "should get records" do
    get clinics_records_url
    assert_response :success
  end

  test "should get records_by_clinic" do
    get clinics_records_by_clinic_url
    assert_response :success
  end

  test "should get upload_file" do
    get clinics_upload_file_url
    assert_response :success
  end

  test "should get search_users_by_clinic" do
    get clinics_search_users_by_clinic_url
    assert_response :success
  end

  test "should get search_users" do
    get clinics_search_users_url
    assert_response :success
  end

end
