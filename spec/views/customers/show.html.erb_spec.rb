require 'rails_helper'

RSpec.describe "customers/show", type: :view do
  before(:each) do
    @customer = assign(:customer, Customer.create!(
      :Phone => "Phone",
      :LastName => "Last Name",
      :FirstName => "First Name",
      :AddressNumber => "Address Number",
      :StreetName => "Street Name",
      :City => "City",
      :State => "State",
      :Zip => 2,
      :Directions => "Directions",
      :LastOrderNumber => 3,
      :TotalOrderCount => 4,
      :TotalOrderDollars => "9.99",
      :BadCkCount => 5,
      :BadCkTotal => "9.99",
      :LongDelivery => false,
      :Notes => "Notes"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Phone/)
    expect(rendered).to match(/Last Name/)
    expect(rendered).to match(/First Name/)
    expect(rendered).to match(/Address Number/)
    expect(rendered).to match(/Street Name/)
    expect(rendered).to match(/City/)
    expect(rendered).to match(/State/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Directions/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Notes/)
  end
end
