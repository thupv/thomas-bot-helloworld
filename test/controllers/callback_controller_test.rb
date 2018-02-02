require 'test_helper'

class CallbackControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get callback_index_url
    assert_response :success
  end

  test "should get received_data" do
    get callback_received_data_url
    assert_response :success
  end

end
