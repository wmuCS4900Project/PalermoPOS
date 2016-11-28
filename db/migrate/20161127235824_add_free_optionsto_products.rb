class AddFreeOptionstoProducts < ActiveRecord::Migration[5.0]
  def change
      change_table :products do |t|
      t.string :freeoptions
    end
  end
end
