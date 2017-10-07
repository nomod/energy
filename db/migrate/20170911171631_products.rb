class Products < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :friendly_url
      t.integer :category_id, default:0 # родительская категория / по умолчанию нет
      t.string :product_title
      t.boolean :view_main, defaut: false # выводить на главную или нет / по умолчанию нет
      t.string :image
      t.integer :price

      t.timestamps
    end
  end
end
