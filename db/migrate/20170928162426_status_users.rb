class StatusUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :status_users do |t|
      t.string :user_status_name

      t.timestamps
    end
  end
end
