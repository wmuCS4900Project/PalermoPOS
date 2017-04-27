class Customer < ApplicationRecord
  has_many :orders, :dependent => :destroy
  after_initialize :init
  
  validates :FirstName, format: { with: /\A[\w\s\-\.]+\z/, message: "only allows letters, numbers, dashes, periods, underscores, and spaces." }, allow_blank: true
  validates :LastName, format: { with: /\A[\w\s\-\.]+\z/, message: "only allows letters, numbers, dashes, periods, underscores, and spaces." }, allow_blank: true
  validates :Phone, format: { with: /\A[\w\s\-\.]+\z/, message: "only allows letters, numbers, dashes, periods, underscores, and spaces." }, allow_blank: true
  validates :AddressNumber, format: { with: /\A[\w\s\-\.]+\z/, message: "only allows letters, numbers, periods, underscores, and spaces." }, allow_blank: true
  validates :StreetName, format: { with: /\A[\w\s\-\.]+\z/, message: "only allows letters, numbers, dashes, periods, underscores, and spaces." }, allow_blank: true
  validates :City, format: { with: /\A[\w\s\-\.]+\z/, message: "only allows letters, numbers, dashes, underscores, periods, and spaces." }, allow_blank: true
  validates :State, format: { with: /\A[\w\s\-\.]+\z/, message: "only allows letters, numbers, dashes, underscores, periods, and spaces." }, allow_blank: true
  validates :Zip, numericality: { only_integer: true }, allow_blank: true
  validates :Directions, format: { with: /\A[\w\s\-\.]+\z/, message: "only allows letters, numbers, dashes, underscores, periods, and spaces." }, allow_blank: true
  validates :LastOrderNumber, numericality: { only_integer: true }, allow_blank: true
  validates :TotalOrderCount, numericality: { only_integer: true }, allow_blank: true
  validates :TotalOrderDollars, numericality: true, allow_blank: true
  validates :BadCkCount, numericality: { only_integer: true }, allow_blank: true
  validates :BadCkTotal, numericality: true, allow_blank: true
  validates :LongDelivery, inclusion: { in: [ true, false ] }, allow_blank: true
  validates :Notes, format: { with: /\A[\w\s\-\.]+\z/, message: "only allows letters, numbers, dashes, underscores, periods, and spaces." }, allow_blank: true
  
  def init
    self.LongDelivery = false if self.LongDelivery.nil?
  end
end
