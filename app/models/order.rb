class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :user
  belongs_to :driver
  has_many :orderlines
end
