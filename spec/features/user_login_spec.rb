
require "rails_helper"

describe "admin creates a new user", :type => :feature do
  
  before(:each) do
    @u1 = FactoryGirl.create :user, :admin, id: "1", username: "admin", password: "admin123", Name: "admin"
  end
  
  it 'logs into admin' do
    visit '/login'
    sign_in_with('admin', 'admin123')
    expect(page).to have_content('Logged in as username')
    expect(page).to have_content('Name: admin')
    
  end

  
  def sign_in_with(username, password)
    fill_in 'session_username', with: username
    fill_in 'session_password', with: password
    click_button 'Log in'
  end

end