require 'test_helper'

class DemosControllerTest < ActionController::TestCase
  test "should get artsale" do
    get :artsale
    assert_response :success
  end

  test "should get groovy" do
    get :groovy
    assert_response :success
  end

  test "should get imgbrowser" do
    get :imgbrowser
    assert_response :success
  end
  
  test "should get openmrs" do
    get :openmrs
    assert_response :success
  end

  test "should get quickshow" do
    get :quickshow
    assert_response :success
  end

  test "should get slidepuzzle" do
    get :slidepuzzle
    assert_response :success
  end

  test "should get untouchable" do
    get :untouchable
    assert_response :success
  end
end
