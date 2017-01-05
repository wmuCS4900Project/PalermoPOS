class Product < ApplicationRecord
    has_many :orderlines, :dependent => :destroy
    belongs_to :category
end
