class Order < ApplicationRecord

  has_and_belongs_to_many :users
  has_and_belongs_to_many :unknown_users
  belongs_to :order_status

end