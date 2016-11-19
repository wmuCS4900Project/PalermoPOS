class Order < ApplicationRecord
    has_many :orderlines
end
