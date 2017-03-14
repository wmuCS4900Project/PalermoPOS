
require "rails_helper"

describe "redirects for not logged in work", :type => :feature do
  
  it 'redirects to login page' do
    visit '/orders'
    expect(page).to have_content('You must be logged in!')
    
    visit '/management'
    expect(page).to have_content('You must be logged in!')
    
    visit '/customers'
    expect(page).to have_content('You must be logged in!')
    
    visit '/options'
    expect(page).to have_content('You must be logged in!')
  end
  

end