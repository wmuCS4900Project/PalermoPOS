class Customer < ApplicationRecord
    has_many :orders, :dependent => :destroy
    after_initialize :init
        
  def init
    self.LongDelivery = false if self.LongDelivery.nil?
  end
end
