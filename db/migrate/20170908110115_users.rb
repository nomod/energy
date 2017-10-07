class Users < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :surname
      t.string :email, index: true, unique: true
      t.string :password_digest
      t.string :remember_token, index: true
      t.boolean :admin, default: false
      t.string :confirm_token #токен для подтверждения регистрации по почте
      t.boolean :email_confirmed, default: false #метка - подтверждена регистрация или нет
      t.string :reset_password #для сброса пароля
      t.datetime :reset_sent_at #временная метка действия для сброса пароля
      t.boolean :status, default: false #метка - подтвержден пользователь админом или нет

      t.timestamps
    end
  end
end