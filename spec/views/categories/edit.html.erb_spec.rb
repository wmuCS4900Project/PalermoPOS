require 'rails_helper'

RSpec.describe "categories/edit", type: :view do
  before(:each) do
    @category = assign(:category, Category.create!(
      :Name => "MyString",
      :Splits => false
    ))
  end

  it "renders the edit category form" do
    render

    assert_select "form[action=?][method=?]", category_path(@category), "post" do

      assert_select "input#category_Name[name=?]", "category[Name]"

      assert_select "input#category_Splits[name=?]", "category[Splits]"
    end
  end
end
