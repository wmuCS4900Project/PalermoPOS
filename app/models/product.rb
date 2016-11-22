class Product < ApplicationRecord
    has_many :orderlines
    enum Category: {
        pizza: 0,
        subs: 1,
        drinks: 2,
        dinners: 3,
        salads: 4,
        desserts: 5
    }
end
