class AddPhoneInUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :phone, :integer, limit: 8
  end
end
