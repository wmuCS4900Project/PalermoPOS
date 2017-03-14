class Coupon < ApplicationRecord
  
  enum Type: [:dollars, :percent]
  serialize :Requirements
  serialize :Requirements2
  
end
