class AddDoubleOfToOptions < ActiveRecord::Migration[5.0]
  def change
    add_column :options, :DoubleOf, :integer 
  end
end
