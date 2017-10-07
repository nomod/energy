class Productatr < ApplicationRecord

  has_and_belongs_to_many :products
  has_and_belongs_to_many :cards

end