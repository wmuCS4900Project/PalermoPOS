
require "rails_helper"

describe "delete user test", :type => :feature do
  
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
    
    page.accept_alert 'Are you sure?' do
      click_button('Destroy')
    end
    
    
    expect(page).to have_content('User was successfully destroyed.')
    expect(page).not_to have_content('User1guy')
    expect(page).not_to have_content('user1')
    
  end
  
  def sign_in_with(username, password)
    fill_in 'session_username', with: username
    fill_in 'session_password', with: password
    click_button 'Log in'
  end
  

end