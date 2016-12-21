class User < ApplicationRecord
    has_many :orders, :dependent => :destroy
    has_many :drivers, :dependent => :destroy
end
