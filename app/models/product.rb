class Product < ApplicationRecord
    has_many :orderlines
    belongs_to :category
end
