
require "rails_helper"

describe "refunds tests", :type => :feature do
  
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
  
  it 'check refund new selection' do
    
    visit '/refunds/new'

    option = first('#order_id option').text
    select option, from: 'order_id'
    
    click_button 'Use Order'

    expect(page).to have_content('Order #' + option)
    
  end
  
  it 'new fund has necessary html elements' do
    visit '/refunds/new'

    option = first('#order_id option').text
    select option, from: 'order_id'
    
    click_button 'Use Order'

    # Look for header
    expect(page).to have_content('New Refund') 

    # Look for button that updates refund
    expect(page).to have_selector('button.add-refund')

    expect(page).to have_selector('#include-tax')
    expect(page).to have_selector('#refund_total')

    check 'include-tax'

    # Subtotal should now be visible
    expect(page).to have_selector('#refund_subtotal')

  end
  
  # @todo Check javascript update of refund totals w/ and w/o include-tax

  # @todo Check javascript check refund submission

  # @todo Check that adding refund changes refund button to "refunded!" 
  # on orders page 

  # @todo check number validation
  
  def sign_in_with(username, password)
    fill_in 'session_username', with: username
    fill_in 'session_password', with: password
    click_button 'Log in'
  end
end