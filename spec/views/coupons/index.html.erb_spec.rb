require 'rails_helper'

RSpec.describe "coupons/index", type: :view do
  before(:each) do
    assign(:coupons, [
      Coupon.create!(
        :Name => "Name",
        :Type => 2,
        :DollarsOff => "9.99",
        :PercentOff => 3,
        :Requirements => "Requirements"
      ),
      Coupon.create!(
        :Name => "Name",
        :Type => 2,
        :DollarsOff => "9.99",
        :PercentOff => 3,
        :Requirements => "Requirements"
      )
    ])
  end

  it "renders a list of coupons" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Requirements".to_s, :count => 2
  end
end
