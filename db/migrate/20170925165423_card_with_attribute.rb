class CardWithAttribute < ActiveRecord::Migration[5.0]
  def change
    create_table :card_with_attributes do |t|
      t.integer :card_id
      t.integer :product_atrs_id

      t.timestamps
    end
  end
end
