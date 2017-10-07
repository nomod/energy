class Category < ApplicationRecord

  mount_uploader :image, CategoryUploader

  has_many :products, dependent: :delete_all

  #определяем связь родитель-потомок
  belongs_to :parent, class_name: 'Category'
  has_many :children, class_name: 'Category', foreign_key: 'parent_id', dependent: :destroy
end