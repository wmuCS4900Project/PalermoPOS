
require "rails_helper"

describe "orders tests", :type => :feature do
  
  def sign_in_with(username, password)
    fill_in 'session_username', with: username
    fill_in 'session_password', with: password
    click_button 'Log in'
  end
  
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
  it 'starts a new order' do
    
    visit '/orders'
    expect(page).to have_current_path(orders_path)
    expect(page).to have_content('No orders yet today')
    
    click_link 'New Order'
    expect(page).to have_current_path(orders_custsearch_path)
    expect(page).to have_content('Customer Search')
    
    click_button 'Search'
    expect(page).to have_content('Customer Search')
    expect(page).to have_content('Jim Smith')
    
    click_link 'Pickup'
    expect(page).to have_content('Current Order for Jim Smith')
    expect(page).to have_content('Jim Smith')
    expect(page).to have_content('Subtotal: $0.00')
    expect(page).to have_content('12 Inch')
    expect(page).to have_content('Subs')
    
    click_link '12 Inch'
    expect(page).to have_content('12 Inch Pizza')
    expect(page).to have_content('12 Inch Deluxe')
    expect(page).to have_content('Plain Sub')
    
    click_link '12 Inch Pizza'
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
    
    check 'w7'
    within(:xpath, '//div[@id="whole"]') do
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
        uncheck('h17')
        check('h112')
      end
      within(:xpath, '//*[@id="halves"]/form/div[1]') do
        check('h111')
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
    expect(page).to have_content('Total $25.95')
    expect(page).to have_content('Sub 24.48')
    expect(page).to have_content('Tax 1.47')
    expect(page).to have_content('Adj 0.00')
    

  end
  

end