
require "rails_helper"

describe "redirects for not logged in work", :type => :feature do
  
  it 'redirects to login page' do
    visit '/orders'
    expect(page).to have_content('Log in')
    expect(page).to have_current_path(login_path)

    visit '/management'
    expect(page).to have_content('Log in')
    
    visit '/customers'
    expect(page).to have_content('Log in')
    
    visit '/options'
    expect(page).to have_content('Log in')
  end
  

end