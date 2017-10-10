class Order_Status < ApplicationRecord

  has_many :orders
  has_many :unknown_users

end