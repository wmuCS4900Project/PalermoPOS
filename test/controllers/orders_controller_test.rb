require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order = orders(:one)
    @cust1 = customers(:one)
  end

  test "should get index" do
    get orders_url
    assert_response :success
  end

  test "should get startorder" do
    get orders_startorder_url
    assert_response :success
  end
  
  test "should get pickoptions" do
    post orders_pickoptions_url, params: { id: 0 }
    assert_response :success
  end
  
  test "should get confirmorder" do
    post orders_confirmorder_url
    assert_response :success
  end
  
  test "should get custsearch" do
    get orders_custsearch_url
    assert_response :success
  end
  
  test "search 1" do
    get order_url(@order), params: { searchcriteria: "phone", criteria: "111" }
    assert_not(@order.nil?)
    puts @results
    puts @cust1
    assert_includes(@results, @cust1, "found it")
  end
  
  test "search 2" do
    get order_url(@order), params: {searchcriteria: "name", criteria: "jim" }
    assert_not(@order.nil?)
    puts @results
    puts @cust1
    assert_includes(@results, @cust1, "found it")
  end
    

  test "should create order" do
    assert_difference('Order.count') do
      get new_order_url
    end

    assert_redirected_to pickoptions_order_url
  end

  test "should show order" do
    get order_url(@order)
    assert_response :success
  end

  test "should get edit" do
    get edit_order_url(@order)
    assert_response :success
  end

  test "should update order" do
    patch order_url(@order), params: { order: {  } }
    assert_redirected_to order_url(@order)
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete order_url(@order)
    end

    assert_redirected_to orders_url
  end
  
end
