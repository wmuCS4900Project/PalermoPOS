require "rails_helper"

describe "coupons tests", :type => :feature do
  
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
  it 'creates a new coupon' do
    
    visit '/coupons'
    expect(page).to have_current_path(coupons_path)
    expect(page).to have_content('Coupons')
    
    click_link 'New Coupon'
    
    fill_in 'Name', with: 'Palermo Duo'
    find("select#Type").value.should eq('dollarsoff')
    fill_in 'DollarsOff', with: '4.25'
    
    page.all(:fillable_field, 'ProductData[]').first.set('Cheesy Bread')
    page.select 'Exact Product', :from => 'ptype0'

    page.all(:fillable_field, 'ProductData[]')[2].set('2')
    page.select 'Category Match', :from => 'ptype1'

    click_button 'Save Coupon'
    
    expect(page).to have_current_path(coupons_path)
    expect(page).to have_content('Palermo Duo')
    
  end
  
  it 'edits that coupon' do
    
    visit '/coupons'
    click_link 'New Coupon'
    fill_in 'Name', with: 'Palermo Duo'
    find("select#Type").value.should eq('dollarsoff')
    fill_in 'DollarsOff', with: '4.25'
    page.all(:fillable_field, 'ProductData[]').first.set('Cheesy Bread')
    page.select 'Exact Product', :from => 'ptype0'
    page.all(:fillable_field, 'ProductData[]')[1].set('2')
    page.select 'Category Match', :from => 'ptype1'
    click_button 'Save Coupon'
    
    click_link 'Edit'
    
    #find("Name").value.should eq('Palermo Duo')
    find("select#Type").value.should eq('dollarsoff')
    expect(page).to have_field('Name', :with => 'Palermo Duo')
    expect(page).to have_field('pdata0', :with => 'Cheesy Bread')
    expect(page).to have_field('pdata1', :with => '2')
    expect(page).to have_select('ptype0', :selected => 'Exact Product')
    expect(page).to have_select('ptype1', :selected => 'Category Match')
    
    
  end
  
end