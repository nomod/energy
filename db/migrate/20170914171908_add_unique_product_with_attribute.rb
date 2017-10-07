class AddUniqueProductWithAttribute < ActiveRecord::Migration[5.0]
  def change
    add_index :product_with_attributes, [:product_id, :product_atrs_id], unique: true
  end
end
