
require "rails_helper"

describe "users integration tests", :type => :feature do
  
  before(:each) do
    @role1 = FactoryGirl.create :role, :admin
    @role1 = FactoryGirl.create :role, :driver
    @u1 = FactoryGirl.create :user, :admin, id: "1", username: "admin", password: "admin123", Name: "admin"
    @u2 = FactoryGirl.create :user, id: "2", username: "user1", password: "user123", Name: "User1guy"
    @cap1 = FactoryGirl.create :cap, :all
    visit '/login'
    sign_in_with('admin', 'admin123')
  end
  
  it 'creates a new user' do

    visit '/signup'
    fill_in 'user_Name', with: 'user2guy'
    fill_in 'user_username', with: 'user2'
    fill_in 'user_password', with: 'use123'
    find(:css, "#roles_[value='driver']").set(true)
    click_button 'Save User'
    
    expect(page).to have_content('Name: user2guy')
    expect(page).to have_content('Username: user2')
    expect(page).to have_content('Roles:')
    expect(page).to have_content('driver')
    
    visit '/logout'
    sign_in_with('user2','use123')
    
    expect(page).to have_content('Dashboard')
    expect(page).to have_content('user2')

  end
  
  it 'edits a user' do
    visit '/users/2'
    expect(page).to have_content('Name: User1guy')
    expect(page).not_to have_content('driver')
    
    visit '/users/2/edit'
    expect(find_field('user_Name').value).to eq 'User1guy'
    fill_in 'user_Name', with: 'User1girl'
    expect(find_field('user_username').value).to eq 'user1'
    fill_in 'user_username', with: 'user1g'
    find(:css, "#roles_[value='driver']").set(true)
    fill_in 'user_password', with: 'user123'
    
    click_button 'Save User'

  end
  
  # it 'deletes a user' do
  #   visit '/users/2'
  #   expect(page).to have_content('Name: User1guy')
  #   expect(page).to have_content('Driver: No')
    
  #   #page.accept_alert 'Are you sure?' do
  #   # click_button('Destroy')
  #   #end
    
    
  #   #expect(page).to have_content('User was successfully destroyed.')
  #   #expect(page).not_to have_content('User1guy')
  #   #expect(page).not_to have_content('user1')
    
  # end
  
  
  
  def sign_in_with(username, password)
    fill_in 'session_username', with: username
    fill_in 'session_password', with: password
    click_button 'Log in'
  end

end