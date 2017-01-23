class Category < ApplicationRecord
    has_many :products, :dependent => :destroy
    has_many :options, :dependent => :destroy
end
