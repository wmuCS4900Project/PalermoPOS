class Order < ApplicationRecord
  belongs_to :user
  belongs_to :customer
  has_many :orderlines, :dependent => :destroy
  
  after_initialize :init
  
  def init
    self.PaidFor ||= false if self.PaidFor.nil?
    self.PaidCash ||= false if self.PaidCash.nil?
    self.Cancelled ||= false if self.Cancelled.nil?
    self.Refunded ||= false if self.Refunded.nil?
    self.Discounts = 0.0
  end
  
end