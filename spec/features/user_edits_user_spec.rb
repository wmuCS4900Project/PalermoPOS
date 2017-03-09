
require "rails_helper"

describe "edit user test", :type => :feature do
  
  before(:each) do
    @u1 = FactoryGirl.create :user, :admin, id: "1", username: "admin", password: "admin123", Name: "admin"
    @u2 = FactoryGirl.create :user, id: "2", username: "user1", password: "user123", Name: "User1guy"
    visit '/login'
    sign_in_with('admin', 'admin123')
  end
  
  it 'edits a user' do
    visit '/users/2'
    expect(page).to have_content('Name: User1guy')
    expect(page).to have_content('Driver: No')
    
    visit '/users/2/edit'
    expect(find_field('user_Name').value).to eq 'User1guy'
    fill_in 'user_Name', with: 'User1girl'
    expect(find_field('user_username').value).to eq 'user1'
    fill_in 'user_username', with: 'user1g'
    find(:css, "#roles_[value='driver']").set(true)
    fill_in 'user_password', with: 'user123'
    
    click_button 'Update User'
    expect(page).to have_content 'User was successfully updated.'
    
    
  end
  
  def sign_in_with(username, password)
    fill_in 'session_username', with: username
    fill_in 'session_password', with: password
    click_button 'Log in'
  end
  

end