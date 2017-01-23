class Orderline < ApplicationRecord
  belongs_to :product
  belongs_to :order
  serialize :Options1
  serialize :Options2
  serialize :Options3
  serialize :Options4
  enum splitstyle: [:whole, :halves, :quarters]
  
  after_initialize :init
  
  def init
    self.OptionCount = BigDecimal.new("0.0")
  end
  
end