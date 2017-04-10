class ChangeTaxNameInRefunds < ActiveRecord::Migration[5.0]
  def change
    #having the same name as in Orders(tax) was causing join issues on sql selects
    rename_column :refunds, :tax, :taxrefunded
  end
end
