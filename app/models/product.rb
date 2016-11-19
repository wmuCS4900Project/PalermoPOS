class Product < ApplicationRecord
    enum ProductCategory: [ :pizza, :sub, :side, :salad, :drink, :dinner, :dessert ]
    has_many :options
end
