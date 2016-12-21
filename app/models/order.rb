class Order < ApplicationRecord
  belongs_to :user
  belongs_to :customer
  has_many :orderlines, :dependent => :destroy
end
