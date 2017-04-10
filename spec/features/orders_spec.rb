
require "rails_helper"

describe "orders tests", :type => :feature do
  
  def sign_in_with(username, password)
    fill_in 'session_username', with: username
    fill_in 'session_password', with: password
    click_button 'Log in'
  end
  
  # unless Gem.win_platform?
  #   headless = Headless.new(display: 99, autopick: true, reuse: false, destroy_at_exit: true).start
  # end
  
  before(:each) do
    FactoryGirl.create :category, :subs
    FactoryGirl.create :category, :pizza
    
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
    FactoryGirl.create :palconfig, :optiondisplayshort

    FactoryGirl.create :role, :admin
    FactoryGirl.create :role, :driver
    FactoryGirl.create :cap, :all
    FactoryGirl.create :user, :admin, id: "1", username: "admin", password: "admin123", Name: "admin"
    FactoryGirl.create :user, id: "2", username: "user1", password: "user123", Name: "User1guy"
    visit '/login'
    sign_in_with('admin', 'admin123')
  end
  
  #not a fan of writing such long tests, but the order process is fairly complex and step by step
  it 'runs through a whole order 1', :js => true do
    
    visit '/orders'
    expect(page).to have_current_path(orders_path)
    expect(page).to have_content('No orders yet today')
    
    click_link 'New Order'
    expect(page).to have_current_path(orders_custsearch_path)
    expect(page).to have_content('Customer Search')
    
    click_button 'Search'
    expect(page).to have_current_path('/orders/custsearch?utf8=%E2%9C%93&searchcriteria=phone&criteria=&commit=Search')
    expect(page).to have_content('Customer Search')
    expect(page).to have_content('Jim Smith')
    
    click_link 'Pickup'
    expect(page).to have_current_path(orders_selectproduct_path(order_id: 1))
    expect(page).to have_content('Jim Smith')
    expect(page).to have_content('Subtotal: $0.00')
    expect(page).to have_content('12 Inch')
    expect(page).to have_content('Subs')
    
    click_link '12 Inch'
    expect(page).to have_content('12 Inch Pizza')
    expect(page).to have_content('12 Inch Deluxe')

    click_link '12 Inch Pizza'
    expect(page).to have_current_path(orders_chooseoptions_path(order_id: 1, orderline_id: 1))
    expect(page).to have_content('Subtotal: $8.99')
    expect(page).to have_content('Tax: $0.54')
    expect(page).to have_content('Total: $9.53')
    within('.orderinfo1') do
      expect(page).to have_content('12 Inch Pizza')
      expect(page).to have_content('$8.99')
    end
    expect(page).to have_content('Ham')
    expect(page).to have_content('Sau')
    expect(page).to have_content('Mus')
    expect(page).to have_content('Oni')
    expect(page).to have_content('Pep')
    expect(page).to have_content('xCHS')
    
    within(:xpath, '//div[@id="whole"]') do
      #find("input[type='checkbox'][#nocheck[value='7']]", visible: false).set(true)
      # find("#nocheck[value='7']").hover
      # page.driver.click_at_current_position
      #find("input[type='checkbox'][value='7']", visible: false).set(true)
      find('label[id=lw7]').click
      # find("input[type='checkbox'][value='7']", visible: false).hover
      # page.driver.click_at_current_position
      click_button 'Save Item'
    end
    expect(page).to have_content('Subtotal: $9.99')
    expect(page).to have_content('Tax: $0.60')
    expect(page).to have_content('Total: $10.59')
    within('.orderinfo1') do
      expect(page).to have_content('12 Inch Pizza')
      expect(page).to have_content('Ham')
      expect(page).to have_content('$9.99')
    end
    
    click_link '12 Inch'
    expect(page).to have_content('12 Inch Pizza')
    expect(page).to have_content('12 Inch Deluxe')
    expect(page).to have_content('Plain Sub')
    
    click_link '12 Inch Deluxe'
    expect(page).to have_content('Subtotal: $22.98')
    expect(page).to have_content('Tax: $1.38')
    expect(page).to have_content('Total: $24.36')
    within('.orderinfo1') do
      expect(page).to have_content('12 Inch Deluxe')
      expect(page).to have_content('$12.99')
    end
    expect(page).to have_content('Ham')
    expect(page).to have_content('Sau')
    expect(page).to have_content('Mus')
    expect(page).to have_content('Oni')
    expect(page).to have_content('Pep')
    expect(page).to have_content('xCHS')
    
    click_link "Halves"
    within(:xpath, '//div[@id="halves"]') do
      within(:xpath, '//*[@id="halves"]/form/div[1]') do
        find('label[id=lh17]').click
        find('label[id=lh112]').click
        # uncheck('h17')
        # check('h112')
      end
      within(:xpath, '//*[@id="halves"]/form/div[1]') do
        #check('h111')
        find('label[id=lh111]').click
      end
    end
    
    within(:xpath, '//div[@id="halves"]') do
      click_button 'Save Item'
    end
    expect(page).to have_content('Subtotal: $24.48')
    expect(page).to have_content('Tax: $1.47')
    expect(page).to have_content('Total: $25.95')
    within('.orderinfo1') do
      expect(page).to have_content('12 Inch Pizza')
      expect(page).to have_content('-Ham')
      expect(page).to have_content('xCHS')
      expect(page).to have_content('Mus')
      expect(page).to have_content('$14.49')
    end
    
    click_button 'Submit Only'
    expect(page).to have_current_path(orders_path)
    expect(page).to have_content('Walk In Customer')
    expect(page).to have_content('Order Total')
    expect(page).to have_content('$25.95')
    expect(page).to have_content('Cash Out')
    
    click_link 'Receipt'
    expect(page).to have_current_path('/orders/receipt?id=1&print=no')
    expect(page).to have_content('Total $25.95')
    expect(page).to have_content('Sub 24.48')
    expect(page).to have_content('Tax 1.47')
    expect(page).to have_content('Adj 0.00')
    
    click_link 'Back'
    expect(page).to have_current_path(orders_path)
    
    click_link 'Cash Out'
    expect(page).to have_current_path('/orders/cashout?id=1')
    expect(page).to have_content('Cash Out Order 1 for Jim Smith')
    expect(page).to have_content('Total $25.95')
    
    #click_button('$20 and Change')
    #expect(page).to have_current_path('/orders/cashout?id=1')
    
    click_button '4'
    click_button '0'
    click_button '0'
    click_button '0'
    expect(page).to have_content('Total Out $ 40.00')
    click_button 'CASH out'
    
    #click_button('$40 and Change')
    #wait_for_ajax
    #expect(page).to have_current_path('/orders/cashedout')
    expect(page).to have_content('Paid: Order 1')
    
  end
  
  # #it does let us copy and paste and try other numbers!
  # it 'runs through a whole order 2' do
    
  #   #do this one with the user, not admin
  #   click_link 'Log Out'
  #   visit '/login'
  #   sign_in_with('user', 'user123')
    
  #   visit '/orders'
  #   expect(page).to have_current_path(orders_path)
  #   expect(page).to have_content('No orders yet today')
    
  #   click_link 'New Order'
  #   expect(page).to have_current_path(orders_custsearch_path)
  #   expect(page).to have_content('Customer Search')
    
  #   click_button 'Search'
  #   expect(page).to have_current_path('/orders/custsearch?utf8=%E2%9C%93&searchcriteria=phone&criteria=&commit=Search')
  #   expect(page).to have_content('Customer Search')
  #   expect(page).to have_content('Jim Smith')
    
  #   click_link 'Pickup'
  #   expect(page).to have_current_path(orders_selectproduct_path(order_id: 1))
  #   expect(page).to have_content('Jim Smith')
  #   expect(page).to have_content('Subtotal: $0.00')
  #   expect(page).to have_content('12 Inch')
  #   expect(page).to have_content('Subs')
    
  #   click_link '12 Inch'
  #   expect(page).to have_content('12 Inch Pizza')
  #   expect(page).to have_content('12 Inch Deluxe')
  #   expect(page).to have_content('Plain Sub')
    
  #   click_link '12 Inch Pizza'
  #   expect(page).to have_current_path(orders_chooseoptions_path(order_id: 1, orderline_id: 1))
  #   expect(page).to have_content('Subtotal: $8.99')
  #   expect(page).to have_content('Tax: $0.54')
  #   expect(page).to have_content('Total: $9.53')
  #   within('.orderinfo1') do
  #     expect(page).to have_content('12 Inch Pizza')
  #     expect(page).to have_content('$8.99')
  #   end
  #   expect(page).to have_content('Ham')
  #   expect(page).to have_content('Sau')
  #   expect(page).to have_content('Mus')
  #   expect(page).to have_content('Oni')
  #   expect(page).to have_content('Pep')
  #   expect(page).to have_content('xCHS')
    
  #   check 'w7'
  #   within(:xpath, '//div[@id="whole"]') do
  #     click_button 'Save Item'
  #   end
  #   expect(page).to have_content('Subtotal: $9.99')
  #   expect(page).to have_content('Tax: $0.60')
  #   expect(page).to have_content('Total: $10.59')
  #   within('.orderinfo1') do
  #     expect(page).to have_content('12 Inch Pizza')
  #     expect(page).to have_content('Ham')
  #     expect(page).to have_content('$9.99')
  #   end
    
  #   click_link '12 Inch'
  #   expect(page).to have_content('12 Inch Pizza')
  #   expect(page).to have_content('12 Inch Deluxe')
  #   expect(page).to have_content('Plain Sub')
    
  #   click_link '12 Inch Deluxe'
  #   expect(page).to have_content('Subtotal: $22.98')
  #   expect(page).to have_content('Tax: $1.38')
  #   expect(page).to have_content('Total: $24.36')
  #   within('.orderinfo1') do
  #     expect(page).to have_content('12 Inch Deluxe')
  #     expect(page).to have_content('$12.99')
  #   end
  #   expect(page).to have_content('Ham')
  #   expect(page).to have_content('Sau')
  #   expect(page).to have_content('Mus')
  #   expect(page).to have_content('Oni')
  #   expect(page).to have_content('Pep')
  #   expect(page).to have_content('xCHS')
    
  #   click_link "Halves"
  #   within(:xpath, '//div[@id="halves"]') do
  #     within(:xpath, '//*[@id="halves"]/form/div[1]') do
  #       uncheck('h17')
  #       check('h112')
  #     end
  #     within(:xpath, '//*[@id="halves"]/form/div[1]') do
  #       check('h111')
  #     end
  #   end
    
  #   within(:xpath, '//div[@id="halves"]') do
  #     click_button 'Save Item'
  #   end
  #   expect(page).to have_content('Subtotal: $24.48')
  #   expect(page).to have_content('Tax: $1.47')
  #   expect(page).to have_content('Total: $25.95')
  #   within('.orderinfo1') do
  #     expect(page).to have_content('12 Inch Pizza')
  #     expect(page).to have_content('-Ham')
  #     expect(page).to have_content('xCHS')
  #     expect(page).to have_content('Mus')
  #     expect(page).to have_content('$14.49')
  #   end
    
  #   click_button 'Submit Only'
  #   expect(page).to have_current_path(orders_path)
  #   expect(page).to have_content('Walk In Customer')
  #   expect(page).to have_content('Order Total')
  #   expect(page).to have_content('$25.95')
  #   expect(page).to have_content('Cash Out')
    
  #   click_link 'Receipt'
  #   expect(page).to have_current_path('/orders/receipt?id=1&print=no')
  #   expect(page).to have_content('Total $25.95')
  #   expect(page).to have_content('Sub 24.48')
  #   expect(page).to have_content('Tax 1.47')
  #   expect(page).to have_content('Adj 0.00')
    
  #   click_link 'Back'
  #   expect(page).to have_current_path(orders_path)
    
  #   click_link 'Cash Out'
  #   expect(page).to have_current_path('/orders/cashout?id=1')
  #   expect(page).to have_content('Cash Out Order 1 for Jim Smith')
  #   expect(page).to have_content('Total $25.95')
    
  #   click_button('$20 and Change')
  #   expect(page).to have_current_path('/orders/cashout?id=1')
    
  #   click_button('$40 and Change')
  #   wait_for_ajax
  #   expect(page).to have_current_path('/orders/cashedout')
  #   expect(page).to have_content('Paid: Order 1')
    
  # end
  

end