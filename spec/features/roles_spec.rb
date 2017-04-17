
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
    #TODO WRITE ME
  end
  
  it 'edits a role' do
    #TODO WRITE ME
  end
  
  it 'deletes a role' do
    #TODO WRITE ME
  end
  
  
  def sign_in_with(username, password)
    
  end

end