class Order < ApplicationRecord
  belongs_to :user
  belongs_to :customer
  has_many :orderlines, :dependent => :destroy
  serialize :Coupons
  
  after_initialize :init
  
  def init
    self.PaidFor ||= false if self.PaidFor.nil?
    self.PaidCash ||= false if self.PaidCash.nil?
    self.Cancelled ||= false if self.Cancelled.nil?
    self.Refunded ||= false if self.Refunded.nil?
    self.Discounts = 0.0 if self.Discounts.nil?
    self.Subtotal = 0.0 if self.Subtotal.nil?
    self.Tax = 0.0 if self.Tax.nil?
    self.Tip = 0.0 if self.Tip.nil?
    self.AmountPaid = 0.0 if self.AmountPaid.nil?
    self.ChangeDue = 0.0 if self.ChangeDue.nil?
    self.RefundedTotal = 0.0 if self.RefundedTotal.nil?
    self.ManualDiscount = 0.0 if self.ManualDiscount.nil?
    self.DeliveryCharge = 0.0 if self.DeliveryCharge.nil?
    self.Comments = '' if self.Comments.nil?

  end
  
end