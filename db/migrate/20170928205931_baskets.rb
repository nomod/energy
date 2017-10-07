class Baskets < ActiveRecord::Migration[5.0]
  def change
    create_table :baskets do |t|
      t.integer :product_id
      t.integer :number #кол-во товара в корзине
      t.integer :order_id #номер заказа
      t.integer :status_user_id #статус пользователя: зарегистрирован или нет

      t.timestamps
    end
  end
end
