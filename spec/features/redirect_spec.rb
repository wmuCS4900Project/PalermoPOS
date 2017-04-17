
require "rails_helper"

describe "redirects for various // ", :type => :feature do
  
  before(:each) do
    FactoryGirl.create :category, :subs
    FactoryGirl.create :category, :pizza
    FactoryGirl.create :category, :fourteen
    
    FactoryGirl.create :option, :sub1
    FactoryGirl.create :option, :sub2
    FactoryGirl.create :option, :sub3
    FactoryGirl.create :option, :sub4
    FactoryGirl.create :option, :sub5
    FactoryGirl.create :option, :sub6
    
    FactoryGirl.create :option, :pizza1
    FactoryGirl.create :option, :pizza2
    FactoryGirl.create :option, :pizza3
    FactoryGirl.create :option, :pizza4
    FactoryGirl.create :option, :pizza5
    FactoryGirl.create :option, :pizza6
    
    FactoryGirl.create :product, :sub1
    FactoryGirl.create :product, :plainpizza
    FactoryGirl.create :product, :deluxepizza
    
    FactoryGirl.create :customer, :one
    
    FactoryGirl.create :palconfig, :delivery
    FactoryGirl.create :palconfig, :longdelivery
    FactoryGirl.create :palconfig, :optiondisplaylong
    
    FactoryGirl.create :role, :admin
    FactoryGirl.create :role, :userdef
    FactoryGirl.create :cap, :all
    FactoryGirl.create :cap, :o1
    FactoryGirl.create :cap, :o2
    FactoryGirl.create :cap, :o3
    FactoryGirl.create :cap, :o4
    FactoryGirl.create :cap, :o5
    FactoryGirl.create :cap, :o6
    FactoryGirl.create :cap, :o7
    FactoryGirl.create :cap, :o8
    FactoryGirl.create :cap, :o9
    FactoryGirl.create :cap, :o10
    FactoryGirl.create :cap, :o11
    FactoryGirl.create :cap, :o12
    FactoryGirl.create :user, :admin, id: "1", username: "admin", password: "admin123", Name: "admin"
    FactoryGirl.create :user, :userdef, id: "2", username: "user1", password: "user123", Name: "User1guy"
    
    FactoryGirl.create :order, :one, :pending, :new
    FactoryGirl.create :order, :two, :completed, :new
    FactoryGirl.create :coupon, :coupon1
    #FactoryGirl.create :orderline, :one

    
  end
  
  def sign_in_with(username, password)
    fill_in 'session_username', with: username
    fill_in 'session_password', with: password
    click_button 'Log in'
  end
  
  it 'redirects to login page' do
    
    #order pages
    visit '/orders'
    expect(page).to have_current_path(login_path)
    visit '/orders/custsearch'
    expect(page).to have_current_path(login_path)
    visit '/orders/delivery'
    expect(page).to have_current_path(login_path)
    visit '/orders/pickup'
    expect(page).to have_current_path(login_path)
    visit '/orders/oldorders'
    expect(page).to have_current_path(login_path)
    visit '/orders/walkin'
    expect(page).to have_current_path(login_path)
    visit '/orders/startorder?custid=1&mode=pickup'
    expect(page).to have_current_path(login_path)
    visit '/orders/startorder?custid=1&mode=delivery'
    expect(page).to have_current_path(login_path)
    visit '/orders/selectproduct?order_id=1'
    expect(page).to have_current_path(login_path)
    visit '/orders/chooseoptions'
    expect(page).to have_current_path(login_path)
    visit '/orders/changeorder'
    expect(page).to have_current_path(login_path)
    visit '/orders/addproducttoorder'
    expect(page).to have_current_path(login_path)
    visit '/orders/commitorder'
    expect(page).to have_current_path(login_path)
    visit '/orders/selectcoupons'
    expect(page).to have_current_path(login_path)
    visit '/orders/addcoupons'
    expect(page).to have_current_path(login_path)
    visit '/orders/recalcForOrderlineDelete'
    expect(page).to have_current_path(login_path)
    visit '/orders/addPreviousOrderItems'
    expect(page).to have_current_path(login_path)
    visit '/orders/addoptions'
    expect(page).to have_current_path(login_path)
    visit '/orders/all'
    expect(page).to have_current_path(login_path)
    visit '/orders/show'
    expect(page).to have_current_path(login_path)
    visit '/orders/receipt'
    expect(page).to have_current_path(login_path)
    visit '/orders/cashout'
    expect(page).to have_current_path(login_path)
    visit '/orders/cashedout'
    expect(page).to have_current_path(login_path)
    visit '/orders/cancel'
    expect(page).to have_current_path(login_path)
    visit '/orders/update'
    expect(page).to have_current_path(login_path)
    visit '/orders/destroy'
    expect(page).to have_current_path(login_path)
    
    
    #management pages
    visit '/management'
    expect(page).to have_current_path(login_path)
    visit '/management/cashoutdrivers'
    expect(page).to have_current_path(login_path)
    visit '/management/endofday'
    expect(page).to have_current_path(login_path)
    visit '/palconfigs'
    expect(page).to have_current_path(login_path)
    visit '/palconfigs/1/edit'
    expect(page).to have_current_path(login_path)
    
    #customer pages
    visit '/customers'
    expect(page).to have_current_path(login_path)
    visit '/customers/1'
    expect(page).to have_current_path(login_path)
    visit '/customers/1/edit'
    expect(page).to have_current_path(login_path)
    visit '/customers/destroy'
    expect(page).to have_current_path(login_path)
    visit '/customers/new'
    expect(page).to have_current_path(login_path)
    
    #options pages
    visit '/options'
    expect(page).to have_current_path(login_path)
    visit '/options/1/edit'
    expect(page).to have_current_path(login_path)
    visit '/options/destroy'
    expect(page).to have_current_path(login_path)
    visit '/options/new'
    expect(page).to have_current_path(login_path)
    visit '/options/1'
    expect(page).to have_current_path(login_path)
    visit '/options/changeall'
    expect(page).to have_current_path(login_path)
    
    #product pages
    visit '/products'
    expect(page).to have_current_path(login_path)
    visit '/products/new'
    expect(page).to have_current_path(login_path)
    visit '/products/1/edit'
    expect(page).to have_current_path(login_path)
    visit '/products/destroy'
    expect(page).to have_current_path(login_path)
    visit '/products/changeall'
    expect(page).to have_current_path(login_path)
    
    #coupon pages
    visit '/coupons'
    expect(page).to have_current_path(login_path)
    visit '/coupons/new'
    expect(page).to have_current_path(login_path)
    visit '/coupons/1/edit'
    expect(page).to have_current_path(login_path)
    visit '/coupons/destroy'
    expect(page).to have_current_path(login_path)
    
    #user pages
    visit '/users'
    expect(page).to have_current_path(login_path)
    visit '/users/new'
    expect(page).to have_current_path(login_path)
    visit '/users/1'
    expect(page).to have_current_path(login_path)
    visit '/users/1/edit'
    expect(page).to have_current_path(login_path)
    visit '/users/destroy'
    expect(page).to have_current_path(login_path)
    
  end
  
  it 'does not redirect admin' do 
    
    #sign in first
    visit '/login'
    sign_in_with('admin', 'admin123')
    
    #order pages
    puts "1"
    visit '/orders'
    expect(page).to have_current_path(orders_path)
    puts "2"
    visit '/orders/custsearch'
    expect(page).to have_current_path(orders_custsearch_path)
    puts "3"
    visit '/orders/delivery'
    expect(page).to have_current_path(orders_delivery_path)
    puts "4"
    visit '/orders/pickup'
    expect(page).to have_current_path(orders_pickup_path)
    puts "5"
    visit '/orders/oldorders'
    expect(page).to have_current_path(orders_oldorders_path)
    puts "6"
    visit '/orders/walkin'
    expect(page).to have_current_path(orders_custsearch_path)
    puts "7"
    visit '/orders/startorder?custid=1&mode=pickup'
    expect(page).to have_current_path(orders_selectproduct_path(order_id: 3))
    puts "8"
    visit '/orders/startorder?custid=1&mode=delivery'
    expect(page).to have_current_path(orders_selectproduct_path(order_id: 4))
    puts "9"
    visit '/orders/selectproduct?order_id=1'
    expect(page).to have_current_path(orders_selectproduct_path(order_id: 1))
    puts "10"
    visit '/orders/chooseoptions?' ##
    expect(page).to have_current_path(orders_path)
    puts "11"
    visit '/orders/changeorder?order_id=1'
    expect(page).to have_current_path(orders_selectproduct_path(order_id: 1))
    puts "12"
    visit '/orders/selectcoupons?order_id=1'
    expect(page).to have_current_path(orders_selectcoupons_path(order_id: 1))
    puts "13"
    visit '/orders/addPreviousOrderItems?order_id=1' ##
    expect(page).to have_current_path(orders_selectproduct_path(order_id: 1))
    puts "14"
    visit '/orders/receipt?id=1&&print=no'
    expect(page).to have_current_path(orders_receipt_path(id: 1, print: 'no'))
    puts "15"
    visit '/orders/cashout?id=1'
    expect(page).to have_current_path(orders_cashout_path(id: 1))
    puts "16"
    visit '/orders/cancel?order_id=2'
    expect(page).to have_current_path(orders_path)
    
    
    #management pages
    visit '/management'
    expect(page).to have_current_path(management_path)
    visit '/management/cashoutdrivers'
    expect(page).to have_current_path(management_cashoutdrivers_path)
    visit '/management/endofday'
    expect(page).to have_current_path(management_path)
    visit '/palconfigs'
    expect(page).to have_current_path(palconfigs_path)
    visit '/palconfigs/1/edit'
    expect(page).to have_current_path(edit_palconfig_path(id: 1))
    
    #customer pages
    visit '/customers'
    expect(page).to have_current_path(customers_path)
    visit '/customers/1'
    expect(page).to have_current_path(customer_path(id: 1))
    visit '/customers/1/edit'
    expect(page).to have_current_path(edit_customer_path(id: 1))
    visit '/customers/new'
    expect(page).to have_current_path(new_customer_path)
    
    #options pages
    visit '/options'
    expect(page).to have_current_path(options_path)
    visit '/options/1/edit'
    expect(page).to have_current_path(edit_option_path(id: 1))
    visit '/options/new'
    expect(page).to have_current_path(new_option_path)
    visit '/options/1'
    expect(page).to have_current_path(option_path(id: 1))
    visit '/options/changeall'
    expect(page).to have_current_path(options_changeall_path)
    
    #product pages
    visit '/products'
    expect(page).to have_current_path(products_path)
    visit '/products/new'
    expect(page).to have_current_path(new_product_path)
    visit '/products/1/edit'
    expect(page).to have_current_path(edit_product_path(id: 1))
    visit '/products/changeall'
    expect(page).to have_current_path(products_changeall_path)
    
    #coupon pages
    visit '/coupons'
    expect(page).to have_current_path(coupons_path)
    visit '/coupons/new'
    expect(page).to have_current_path(new_coupon_path)
    visit '/coupons/1/edit'
    expect(page).to have_current_path(edit_coupon_path(id: 1))
    
    #user pages
    visit '/users'
    expect(page).to have_current_path(users_path)
    visit '/users/new'
    expect(page).to have_current_path(new_user_path)
    visit '/users/1'
    expect(page).to have_current_path(user_path(id: 1))
    visit '/users/1/edit'
    expect(page).to have_current_path(edit_user_path(id: 1))
    
  end
  
  it 'sometimes redirects user with some priviledges' do
    #sign in first
    visit '/login'
    sign_in_with('user1', 'user123')
    
    #order pages
    visit '/orders'
    expect(page).to have_current_path(orders_path)
    visit '/orders/custsearch'
    expect(page).to have_current_path(orders_custsearch_path)
    visit '/orders/delivery'
    expect(page).to have_current_path(orders_delivery_path)
    visit '/orders/pickup'
    expect(page).to have_current_path(orders_pickup_path)
    visit '/orders/oldorders'
    expect(page).to have_current_path(orders_oldorders_path)
    visit '/orders/walkin'
    expect(page).to have_current_path(orders_custsearch_path)
    visit '/orders/startorder?custid=1&mode=pickup'
    expect(page).to have_current_path(orders_selectproduct_path(order_id: 5))
    visit '/orders/startorder?custid=1&mode=delivery'
    expect(page).to have_current_path(orders_selectproduct_path(order_id: 6))
    visit '/orders/selectproduct?order_id=1'
    expect(page).to have_current_path(orders_selectproduct_path(order_id: 1))
    visit '/orders/chooseoptions?' 
    expect(page).to have_current_path(orders_path)
    visit '/orders/changeorder?order_id=1'
    expect(page).to have_current_path(orders_selectproduct_path(order_id: 1))
    visit '/orders/selectcoupons?order_id=1'
    expect(page).to have_current_path(orders_selectcoupons_path(order_id: 1))
    visit '/orders/addPreviousOrderItems?order_id=1' 
    expect(page).to have_current_path(orders_selectproduct_path(order_id: 1))
    visit '/orders/receipt?id=1&&print=no'
    expect(page).to have_current_path(orders_receipt_path(id: 1, print: 'no'))
    visit '/orders/cashout?id=1'
    expect(page).to have_current_path(orders_cashout_path(id: 1))
    visit '/orders/cancel?order_id=2'
    expect(page).to have_current_path(orders_path)
    
    
    #management pages
    visit '/management'
    expect(page).to have_current_path(default_index_path)
    visit '/management/cashoutdrivers'
    expect(page).to have_current_path(default_index_path)
    visit '/management/endofday'
    expect(page).to have_current_path(default_index_path)
    visit '/palconfigs'
    expect(page).to have_current_path(default_index_path)
    visit '/palconfigs/1/edit'
    expect(page).to have_current_path(default_index_path)
    
    #customer pages
    visit '/customers'
    expect(page).to have_current_path(customers_path)
    visit '/customers/1'
    expect(page).to have_current_path(customer_path(id: 1))
    visit '/customers/1/edit'
    expect(page).to have_current_path(edit_customer_path(id: 1))
    visit '/customers/new'
    expect(page).to have_current_path(new_customer_path)
    
    #options pages
    visit '/options'
    expect(page).to have_current_path(options_path)
    visit '/options/1/edit'
    expect(page).to have_current_path(options_path)
    visit '/options/new'
    expect(page).to have_current_path(options_path)
    visit '/options/1'
    expect(page).to have_current_path(option_path(id: 1))
    visit '/options/changeall'
    expect(page).to have_current_path(options_path)
    
    #product pages
    visit '/products'
    expect(page).to have_current_path(products_path)
    visit '/products/new'
    expect(page).to have_current_path(products_path)
    visit '/products/1/edit'
    expect(page).to have_current_path(products_path)
    visit '/products/changeall'
    expect(page).to have_current_path(products_path)
    
    #coupon pages
    visit '/coupons'
    expect(page).to have_current_path(coupons_path)
    visit '/coupons/new'
    expect(page).to have_current_path(coupons_path)
    visit '/coupons/1/edit'
    expect(page).to have_current_path(coupons_path)
    
    #user pages
    visit '/users'
    expect(page).to have_current_path(default_index_path)
    visit '/users/new'
    expect(page).to have_current_path(default_index_path)
    visit '/users/1'
    expect(page).to have_current_path(default_index_path)
    visit '/users/1/edit'
    expect(page).to have_current_path(default_index_path)
  end
  

end