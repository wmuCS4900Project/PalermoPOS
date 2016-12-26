class Orderline < ApplicationRecord
  belongs_to :product
  belongs_to :order
  enum splitstyle: [:whole, :halves, :hqq, :quarters]
  
end
