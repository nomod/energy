class ProductWithAttribute < ActiveRecord::Migration[5.0]
  def change
    create_table :product_with_attributes do |t|
      t.integer :product_id
      t.integer :product_atrs_id
      t.string :value

      t.timestamps
    end
  end
end
