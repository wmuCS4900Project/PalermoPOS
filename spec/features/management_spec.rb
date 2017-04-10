require "rails_helper"

describe "management tests", :type => :feature do
  
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
  
  
  #form page ids for multiple fields are pdata#, ptype#, and pops#
  it 'cannot do end of day with a pending order' do
    
    FactoryGirl.create :order, :new, :pending
    visit '/management'
    
    expect(page).to have_content("Management")
    expect(page).to have_content("Cash out drivers")
    expect(page).to have_content("End of day")
    expect(page).to have_content("Configurations")
    
    click_link 'End of day'
    
    expect(current_path).to eq('/management')
    expect(page).to have_content('You may not do End of Day while any orders are still pending!')
    
  end
  
  
end