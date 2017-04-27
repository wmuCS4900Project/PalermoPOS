class Cap < ApplicationRecord
	belongs_to :role
	
	validates :action, format: { with: /\A[\w\s\-\.]+\z/, message: "only allows letters, numbers, dashes, underscores, periods, and spaces." }, allow_blank: false
	validates :object, format: { with: /\A[\w\s\-\.]+\z/, message: "only allows letters, numbers, dashes, underscores, periods, and spaces." }, allow_blank: false
	validates :action, numericality: true, allow_blank: false
end
