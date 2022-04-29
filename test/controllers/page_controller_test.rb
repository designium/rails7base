require "test_helper"

class PageControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers
  setup do
    get '/users/sign_in'
    sign_in users(:one)

  end

  test "should get homepage" do
    get page_homepage_url
    assert_response :success
  end

  test "should get transactions" do
    get page_transactions_url
    assert_response :success
  end

  test "should get login" do
    get page_login_url
    assert_response :success
  end

  test "should get loanrequest" do
    get page_loanrequest_url
    assert_response :success
  end
end
