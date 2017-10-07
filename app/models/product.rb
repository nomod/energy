class Product < ApplicationRecord

  mount_uploader :image, ProductUploader

  belongs_to :category
  has_and_belongs_to_many :productatrs

end