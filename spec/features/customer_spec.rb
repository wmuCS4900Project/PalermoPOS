
require "rails_helper"

describe "customer tests", :type => :feature do
  
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
    FactoryGirl.create :palconfig, :optiondisplayshort
    
    FactoryGirl.create :role, :admin
    FactoryGirl.create :role, :driver
    FactoryGirl.create :cap, :all
    FactoryGirl.create :user, :admin, id: "1", username: "admin", password: "admin123", Name: "admin"
    FactoryGirl.create :user, id: "2", username: "user1", password: "user123", Name: "User1guy"
    visit '/login'
    sign_in_with('admin', 'admin123')
  end
  
  it 'adds a customer' do
    
    visit '/customers/new'
    expect(page).to have_current_path(new_customer_path)
    fill_in 'Phone', with: '6667778888'
    fill_in 'Firstname', with: 'Fred'
    fill_in 'Lastname', with: 'Rogers'
    fill_in 'Addressnumber', with: '123'
    fill_in 'Streetname', with: 'Street St'
    fill_in 'City', with: 'Fairy Tale'
    fill_in 'State', with: 'MI'
    fill_in 'Zip', with: '11111'
    fill_in 'Directions', with: 'turn on your tube tv'
    click_button 'Save Customer'
    
    expect(page).to have_current_path(customer_path(id: 2))
    expect(page).to have_content('Firstname: Fred')
    expect(page).to have_content('Lastname: Rogers')
    expect(page).to have_content('Phone: 6667778888')
    expect(page).to have_content('Directions: turn on your tube tv')
    
  end
  
  it 'deletes a customer' do
    
    visit '/customers'
    expect(page).to have_current_path(customers_path)
    expect(page).to have_content('Smith Jim')
    click_link('Delete')
    
    expect(page).to have_current_path(customers_path)
    expect(page).not_to have_content('Smith Jim')
    
  end
  
  it 'edits a customer' do 
    
    visit '/customers'
    expect(page).to have_current_path(customers_path)
    expect(page).to have_content('Smith Jim')
    click_link('Edit')
    
    expect(page).to have_current_path(edit_customer_path(id: 1))
    fill_in 'Firstname', with: 'Fred'
    fill_in 'Lastname', with: 'Rogers'
    click_button 'Save Customer'
    
    expect(page).to have_current_path(customer_path(id: 1))
    expect(page).to have_content('Firstname: Fred')
    expect(page).to have_content('Lastname: Rogers')
    
    visit '/customers'
    expect(page).to have_current_path(customers_path)
    expect(page).to have_content('Rogers Fred')
    
  end
  
  
  def sign_in_with(username, password)
    fill_in 'session_username', with: username
    fill_in 'session_password', with: password
    click_button 'Log in'
  end
  

end