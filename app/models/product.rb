class Product < ApplicationRecord
    has_many :orderlines, :dependent => :destroy
    belongs_to :category
    validates :Name, presence: true
    validates :Cost, presence: true
    validates :category_id, presence: true
    serialize :freeoptions
end
