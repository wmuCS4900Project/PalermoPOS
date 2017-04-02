
require "rails_helper"

describe "options tests", :type => :feature do
  
  before(:each) do
    @c1 = FactoryGirl.create :category, :subs
    @o1 = FactoryGirl.create :option, :sub1
    @role1 = FactoryGirl.create :role, :admin
    @role2 = FactoryGirl.create :role, :driver
    @cap1 = FactoryGirl.create :cap, :all
    @u1 = FactoryGirl.create :user, :admin, id: "1", username: "admin", password: "admin123", Name: "admin"
    @u2 = FactoryGirl.create :user, id: "2", username: "user1", password: "user123", Name: "User1guy"
    visit '/login'
    sign_in_with('admin', 'admin123')
  end
  
  it 'adds an option' do
    
    visit '/options'
    expect(page).to have_content('Option Name')
    expect(page).to have_content('Create New Option')
    expect(page).to have_content('Ham')
    expect(page).not_to have_content('Bacon')
    
    click_link 'Create New Option'
    expect(page).to have_current_path(new_option_path)
    expect(page).to have_content('New Option')
    fill_in 'option[Name]', with: 'Bacon'
    fill_in 'option[Cost]', with: '2'
    
    click_button 'Save Changes'
    
  end
  
  it 'edits an option' do
    visit '/options/1/edit'
    expect(page).to have_content('Editing Option')
    expect(find_field('option[Name]').value).to eq 'Ham'
    fill_in 'option[Name]', with: 'Sausage'
    expect(find_field('option[Cost]').value).to eq '0.5'
    fill_in 'option[Cost]', with: '2'
    
    click_button 'Save Changes'
    expect(page).to have_current_path(options_path)
    expect(page).to have_content('Sausage')
    
  end
  
  it 'places options on the right sub-pages' do
    
    
    
  end
  
  def sign_in_with(username, password)
    fill_in 'session_username', with: username
    fill_in 'session_password', with: password
    click_button 'Log in'
  end
  

end