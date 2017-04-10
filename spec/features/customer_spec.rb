
require "rails_helper"

describe "options tests", :type => :feature do
  
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
    FactoryGirl.create :customer, :two
    
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
  
  it 'adds an option' do
    
    visit '/options?category_id=all'
    expect(page).to have_content('Option Name')
    expect(page).to have_content('Create New Option')
    expect(page).to have_content('Ham')
    expect(page).not_to have_content('Bacon')
    
    click_link 'Create New Option'
    expect(page).to have_current_path(new_option_path)
    expect(page).to have_content('New Option')
    fill_in 'option[Name]', with: 'Bacon'
    fill_in 'option[Cost]', with: '2'
    
    click_button 'Save Option'
    
  end
  
  
  def sign_in_with(username, password)
    fill_in 'session_username', with: username
    fill_in 'session_password', with: password
    click_button 'Log in'
  end
  

end