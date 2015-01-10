require 'test_helper'

class DemosControllerTest < ActionController::TestCase
  test "should get untouchable" do
    get :untouchable
    assert_response :success
  end

  test "should get slidepuzzle" do
    get :slidepuzzle
    assert_response :success
  end

  test "should get imgbrowser" do
    get :imgbrowser
    assert_response :success
  end

end
