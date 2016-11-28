class Orderline < ApplicationRecord
  belongs_to :product
  belongs_to :order
   enum Split: {
      whole: 0,
      halves: 1,
      halfquarterquarter: 2,
      quarters: 3
  }
end
