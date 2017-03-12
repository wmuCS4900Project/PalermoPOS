require 'rails_helper'

RSpec.describe "coupons/new", type: :view do
  before(:each) do
    assign(:coupon, Coupon.new(
      :Name => "MyString",
      :Type => 1,
      :DollarsOff => "9.99",
      :PercentOff => 1,
      :Requirements => "MyString"
    ))
  end

  it "renders new coupon form" do
    render

    assert_select "form[action=?][method=?]", coupons_path, "post" do

      assert_select "input#coupon_Name[name=?]", "coupon[Name]"

      assert_select "input#coupon_Type[name=?]", "coupon[Type]"

      assert_select "input#coupon_DollarsOff[name=?]", "coupon[DollarsOff]"

      assert_select "input#coupon_PercentOff[name=?]", "coupon[PercentOff]"

      assert_select "input#coupon_Requirements[name=?]", "coupon[Requirements]"
    end
  end
end
