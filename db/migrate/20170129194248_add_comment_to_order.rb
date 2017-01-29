class AddCommentToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :Comments, :string
  end
end
