class UnknownOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :unknown_orders do |t|
      t.string :unknown_remember_token
      t.integer :order_status_id

      t.timestamps
    end
  end
end
