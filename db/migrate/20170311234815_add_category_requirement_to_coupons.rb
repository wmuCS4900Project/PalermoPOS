class AddCategoryRequirementToCoupons < ActiveRecord::Migration[5.0]
  def change
    add_column :coupons, :Requirements2, :string
  end
end
