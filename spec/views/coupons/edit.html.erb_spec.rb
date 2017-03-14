require 'rails_helper'

RSpec.describe "coupons/edit", type: :view do
  before(:each) do
    @coupon = assign(:coupon, Coupon.create!(
      :Name => "MyString",
      :Type => 1,
      :DollarsOff => "9.99",
      :PercentOff => 1,
      :Requirements => "MyString"
    ))
  end

  it "renders the edit coupon form" do
    render

    assert_select "form[action=?][method=?]", coupon_path(@coupon), "post" do

      assert_select "input#coupon_Name[name=?]", "coupon[Name]"

      assert_select "input#coupon_Type[name=?]", "coupon[Type]"

      assert_select "input#coupon_DollarsOff[name=?]", "coupon[DollarsOff]"

      assert_select "input#coupon_PercentOff[name=?]", "coupon[PercentOff]"

      assert_select "input#coupon_Requirements[name=?]", "coupon[Requirements]"
    end
  end
end
