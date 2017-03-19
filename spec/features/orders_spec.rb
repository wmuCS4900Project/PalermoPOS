
require "rails_helper"

describe "options tests", :type => :feature do
  
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
    expect(page).to have_content('Order Subtotal: 0.0')
    expect(page).to have_content('12 Inch')
    expect(page).to have_content('Subs')
    
    click_link '12 Inch'
    expect(page).to have_content('12 Inch Pizza')
    expect(page).to have_content('12 Inch Deluxe')
    expect(page).to have_content('Plain Sub')
    
    click_link '12 Inch Pizza'
    expect(page).to have_content('Order Subtotal: 8.99')
    expect(page).to have_content('Order Taxes: 0.54')
    expect(page).to have_content('Order Total: 9.53')
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
    
  end
  

end