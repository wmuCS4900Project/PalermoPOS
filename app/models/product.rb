class Product < ApplicationRecord
    has_many :orderlines, :dependent => :destroy
    belongs_to :category
    validates :Name, format: { with: /\A[\w\s\-\.]+\z/, message: "only allows letters, numbers, dashes, underscores, periods, and spaces." }, allow_blank: false
    validates :Cost, numericality: true, allow_blank: false
    validates :category_id, numericality: true, allow_blank: false
    validates :Abbreviation, format: { with: /\A[\w\s\-\.]+\z/, message: "only allows letters, numbers, dashes, underscores, periods, and spaces." }, allow_blank: true
    validates :MinimumOptionCharge, numericality: true, allow_blank: false
    validates :Favorite, inclusion: { in: [ true, false ] }, allow_blank: true
    validates :FavoritePriority, numericality: true, allow_blank: true
    serialize :freeoptions
    after_initialize :init
  
  def init
    self.Cost ||= 0.0 if self.Cost.nil?
    self.freeoptions ||= [''] if self.freeoptions.nil?
  end
    
end
