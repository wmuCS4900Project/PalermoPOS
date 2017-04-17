require "rails_helper"

describe "products integration tests", :type => :feature do
  
  def sign_in_with(username, password)
    fill_in 'session_username', with: username
    fill_in 'session_password', with: password
    click_button 'Log in'
  end
  
  before(:each) do
    FactoryGirl.create :category, :subs
    FactoryGirl.create :category, :pizza
    FactoryGirl.create :category, :fourteen
    
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
    FactoryGirl.create :cap, :all
    FactoryGirl.create :user, :admin, id: "1", username: "admin", password: "admin123", Name: "admin"
    visit '/login'
    sign_in_with('admin', 'admin123')
  end
  
  
  #form page ids for multiple fields are pdata#, ptype#, and pops#
  it 'views existing products' do
    visit '/products'
    expect(page).to have_link('Edit', count: 3, exact: true)
    expect(page).to have_link('Delete', count: 3)
    expect(page).to have_content('12 Inch Pizza')
    expect(page).to have_content('Plain Sub')
    expect(page).to have_content('12 Inch Deluxe')
  end
  
  it 'creates a new product' do
    visit '/products'
    click_link 'New Product'
    expect(page).to have_current_path(new_product_path)
    expect(page).to have_button('Save Product')
    expect(page).not_to have_content('Free options')
    
    fill_in 'Name', with: 'Cheesy Bread'
    fill_in 'Cost', with: '6.75'
    page.select '12 Inch Pizzas', :from => 'product[category_id]'
    click_button 'Save Product'
    
    expect(page).to have_current_path(products_path)
    
    expect(page).to have_link('Edit', count: 4, exact: true)
    expect(page).to have_link('Delete', count: 4)
    within(:xpath, '//tr[@class="Cheesy Bread"]') do
      expect(page).to have_content('Cheesy Bread')
    end
    
    
  end
  
  it 'edits a product' do
    visit '/products'
    expect(page).to have_link('Edit', count: 3, exact: true)
    expect(page).to have_link('Delete', count: 3)
    expect(page).to have_content('12 Inch Pizza')
    
    
    within(:xpath, '//tr[@class="12 Inch Pizza"]') do
      click_link 'Edit'
    end
    
    expect(find_field('product[Name]').value).to eq '12 Inch Pizza'
    expect(find_field('product[Cost]').value).to eq '8.99'
    fill_in 'Name', with: '14 Inch Plain'
    fill_in 'Cost', with: '9.99'
    page.select '14 Inch Pizzas', :from => 'product[category_id]'
    click_button 'Save Product'
    
    expect(page).to have_current_path(products_path)
    
    expect(page).to have_link('Edit', count: 3, exact: true)
    expect(page).to have_content('14 Inch Plain')
    expect(page).to have_content('14 Inch Pizzas')

    
  end
  
  it 'deletes a product' do
    #TODO WRITE ME
  end
  
end