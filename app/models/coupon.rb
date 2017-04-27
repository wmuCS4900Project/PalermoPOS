class Coupon < ApplicationRecord
  
  enum Type: [:dollars, :percent]
  validates :Name, format: { with: /\A[\w\s\-\.]+\z/, message: "only allows letters, numbers, dashes, underscores, periods, and spaces." }, allow_blank: false
  validates :DollarsOff, numericality: true, allow_blank: false
  serialize :ProductData
  serialize :ProductType
  serialize :ProductMinOptions

end
