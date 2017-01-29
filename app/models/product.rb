class Product < ApplicationRecord
    has_many :orderlines, :dependent => :destroy
    belongs_to :category
    validates :Name, presence: true
    validates :Cost, presence: true
    validates :category_id, presence: true
    serialize :freeoptions
     after_initialize :init
  
  def init
    self.Cost ||= 0.0 if self.Cost.nil?
  end
    
end
