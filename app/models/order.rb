class Order < ApplicationRecord

  has_and_belongs_to_many :users
  belongs_to :order_status

end