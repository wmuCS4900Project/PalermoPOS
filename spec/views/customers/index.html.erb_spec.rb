require 'rails_helper'

RSpec.describe "customers/index", type: :view do
  before(:each) do
    assign(:customers, [
      Customer.create!(
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
      ),
      Customer.create!(
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
      )
    ])
  end

  it "renders a list of customers" do
    render
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Address Number".to_s, :count => 2
    assert_select "tr>td", :text => "Street Name".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Directions".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Notes".to_s, :count => 2
  end
end
