class Unknown_User < ApplicationRecord

  has_and_belongs_to_many :orders, dependent: :delete_all

  # validates_presence_of :unknown_user_name, :telephone, :email, message: 'заполните поле'
  # validates_length_of :unknown_user_name, minimum: 3, message: 'минимальная длина 3 символа'
  # validates_format_of :unknown_user_name, with: /[\u0410-\u044F]+/i, message: 'пишите русскими буквами'
  # validates_format_of :telephone, with: /\A((8|\+7)[\- ]?)?(\(?\d{3}\)?[\- ]?)?[\d\- ]{7,10}\z/, message: 'некорректный номер'
  # validates_format_of :email, with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: 'неккоректный формат'

end