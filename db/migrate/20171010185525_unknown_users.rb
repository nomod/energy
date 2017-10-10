class UnknownUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :unknown_users do |t|
      t.string :unknown_user_name
      t.string :email
      t.integer :telephone, limit: 8
      t.string :unknown_remember_token, index: true

      t.timestamps
    end
  end
end
