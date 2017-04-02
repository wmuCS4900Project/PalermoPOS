class Refund < ApplicationRecord
	belongs_to :order
	validates :subtotal, presence: true
	validates :total, presence: true
end
