class RenameDoubleOfToChildOf < ActiveRecord::Migration[5.0]
  def change
    rename_column :options, :DoubleOf, :ChildOf
  end
end
