require 'rails_helper'

RSpec.describe "customers/new", type: :view do
  before(:each) do
    assign(:customer, Customer.new(
      :Phone => "MyString",
      :LastName => "MyString",
      :FirstName => "MyString",
      :AddressNumber => "MyString",
      :StreetName => "MyString",
      :City => "MyString",
      :State => "MyString",
      :Zip => 1,
      :Directions => "MyString",
      :LastOrderNumber => 1,
      :TotalOrderCount => 1,
      :TotalOrderDollars => "9.99",
      :BadCkCount => 1,
      :BadCkTotal => "9.99",
      :LongDelivery => false,
      :Notes => "MyString"
    ))
  end

  it "renders new customer form" do
    render

    assert_select "form[action=?][method=?]", customers_path, "post" do

      assert_select "input#customer_Phone[name=?]", "customer[Phone]"

      assert_select "input#customer_LastName[name=?]", "customer[LastName]"

      assert_select "input#customer_FirstName[name=?]", "customer[FirstName]"

      assert_select "input#customer_AddressNumber[name=?]", "customer[AddressNumber]"

      assert_select "input#customer_StreetName[name=?]", "customer[StreetName]"

      assert_select "input#customer_City[name=?]", "customer[City]"

      assert_select "input#customer_State[name=?]", "customer[State]"

      assert_select "input#customer_Zip[name=?]", "customer[Zip]"

      assert_select "input#customer_Directions[name=?]", "customer[Directions]"

      assert_select "input#customer_LastOrderNumber[name=?]", "customer[LastOrderNumber]"

      assert_select "input#customer_TotalOrderCount[name=?]", "customer[TotalOrderCount]"

      assert_select "input#customer_TotalOrderDollars[name=?]", "customer[TotalOrderDollars]"

      assert_select "input#customer_BadCkCount[name=?]", "customer[BadCkCount]"

      assert_select "input#customer_BadCkTotal[name=?]", "customer[BadCkTotal]"

      assert_select "input#customer_LongDelivery[name=?]", "customer[LongDelivery]"

      assert_select "input#customer_Notes[name=?]", "customer[Notes]"
    end
  end
end
