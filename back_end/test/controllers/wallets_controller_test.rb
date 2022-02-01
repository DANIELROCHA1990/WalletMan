require "test_helper"

class WalletsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get wallets_show_url
    assert_response :success
  end

  test "should get create" do
    get wallets_create_url
    assert_response :success
  end

  test "should get update" do
    get wallets_update_url
    assert_response :success
  end

  test "should get destroy" do
    get wallets_destroy_url
    assert_response :success
  end
end
