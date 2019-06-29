require 'test_helper'

class IncomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get income_index_url
    assert_response :success
  end

  test "should get show" do
    get income_show_url
    assert_response :success
  end

  test "should get new" do
    get income_new_url
    assert_response :success
  end

  test "should get edit" do
    get income_edit_url
    assert_response :success
  end

  test "should get destroy" do
    get income_destroy_url
    assert_response :success
  end

end
