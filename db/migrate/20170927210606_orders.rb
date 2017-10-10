class Orders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :order_status_id
      t.integer :status_user_id #статус пользователя: зарегистрирован или нет

      t.timestamps
    end
  end
end
