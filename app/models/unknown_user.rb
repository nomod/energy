class Unknown_User < ApplicationRecord

  has_and_belongs_to_many :orders, dependent: :delete_all

end