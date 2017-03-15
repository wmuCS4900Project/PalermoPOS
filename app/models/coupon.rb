class Coupon < ApplicationRecord
  
  enum Type: [:dollars, :percent]
  serialize :ProductData
  serialize :ProductType
  serialize :ProductMinOptions

end
