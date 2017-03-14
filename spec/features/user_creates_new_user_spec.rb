
require "rails_helper"

describe "admin creates a new user", :type => :feature do
  
  before(:each) do
    @u1 = FactoryGirl.create :user, :admin, id: "1", username: "admin", password: "admin123", Name: "admin"
  end
  
  it 'creates a new user' do
    visit '/login'
    sign_in_with('admin', 'admin123')
    
    visit '/signup'
    fill_in 'user_Name', with: 'user2guy'
    fill_in 'user_username', with: 'user2'
    fill_in 'user_password', with: 'use123'
    find(:css, "#roles_[value='driver']").set(true)
    click_button 'Create User'
    
    expect(page).to have_content('User successfully added')
    expect(page).to have_content('Name: user2guy')
    expect(page).to have_content('Username: user2')
    expect(page).to have_content('Driver: Yes')
    
    visit '/logout'
    sign_in_with('user2','use123')
    
    expect(page).to have_content('Logged in as username')
    expect(page).to have_content('Name: user2guy')
    expect(page).to have_content('Username: user2')
    expect(page).to have_content('Manager: No')
    expect(page).to have_content('Driver: Yes')
    
  end
  
  def sign_in_with(username, password)
    fill_in 'session_username', with: username
    fill_in 'session_password', with: password
    click_button 'Log in'
  end

end