
require "rails_helper"

describe "roles integration tests", :type => :feature do
  
  before(:each) do
    @role1 = FactoryGirl.create :role, :admin
    @role1 = FactoryGirl.create :role, :driver
    @u1 = FactoryGirl.create :user, :admin, id: "1", username: "admin", password: "admin123", Name: "admin"
    @u2 = FactoryGirl.create :user, id: "2", username: "user1", password: "user123", Name: "User1guy"
    @cap1 = FactoryGirl.create :cap, :all
    visit '/login'
    sign_in_with('admin', 'admin123')
  end
  
  it 'creates a new role' do
    visit '/roles'
    click_link 'Add New Role'

    expect(page).to have_current_path('/roles/new')

    fill_in 'role_name', :with => 'This'

    click_button 'Save Role'
    expect(page).to have_content 'Role was successfully created.'
  end
  
  it 'edits a role' do
    visit '/roles/1'
    click_link 'Edit'

    expect(page).to have_current_path('/roles/1/edit')

    fill_in 'role_name', :with => 'That'
    click_button 'Save Role'

    expect(page).to have_content 'Role was successfully updated.'
  end
  
  it 'deletes a role' do
    #TODO WRITE ME
  end
  
  
  def sign_in_with(username, password)
    fill_in 'session_username', with: username
    fill_in 'session_password', with: password
    click_button 'Log in' 
  end

end