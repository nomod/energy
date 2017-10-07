class Category < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.string :category_name
      t.string :friendly_url
      t.integer :parent_id, default:0
      t.boolean :view_main, defaut: false
      t.string :category_content
      t.string :image

      t.timestamps
    end
  end
end

