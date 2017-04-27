class Option < ApplicationRecord
  belongs_to :category
  validates :Name, format: { with: /\A[\w\s\-\.]+\z/, message: "only allows letters, numbers, dashes, underscores, periods, and spaces." }, allow_blank: false
  validates :Cost, numericality: true, allow_blank: false
  validates :category_id, numericality: { only_integer: true }, allow_blank: false
  validates :Abbreviation, format: { with: /\A[\w\s\-\.]+\z/, message: "only allows letters, numbers, dashes, underscores, periods, and spaces." }, allow_blank: true
  validates :ChildOf, numericality: { only_integer: true }, allow_blank: true
end
