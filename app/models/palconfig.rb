class Palconfig < ApplicationRecord
  
  validates :name, format: { with: /\A[\w\s\-\.]+\z/, message: "only allows letters, numbers, dashes, underscores, periods, and spaces." }, allow_blank: false
  validates :val1, format: { with: /\A[\w\s\-\.]+\z/, message: "only allows letters, numbers, dashes, underscores, periods, and spaces." }, allow_blank: false
  validates :val2, format: { with: /\A[\w\s\-\.]+\z/, message: "only allows letters, numbers, dashes, underscores, periods, and spaces." }, allow_blank: true
  validates :desc, format: { with: /\A[\w\s\-\.]+\z/, message: "only allows letters, numbers, dashes, underscores, periods, and spaces." }, allow_blank: true
    
end
