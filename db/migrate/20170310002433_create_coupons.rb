class CreateCoupons < ActiveRecord::Migration[5.0]
  def change
    create_table :coupons do |t|
      t.string :Name
      t.integer :Type
      t.decimal :DollarsOff, :precision => 8, :scale => 2
      t.integer :PercentOff
      t.string :Requirements

      t.timestamps
    end
  end
end
