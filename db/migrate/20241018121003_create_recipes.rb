class CreateRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes do |t|
      t.string :title, null: false
      t.integer :cook_time
      t.integer :prep_time
      t.decimal :ratings
      t.string :cuisine
      t.string :category
      t.string :author
      t.string :image
      t.string :row_ingredients, array: true, default: []

      t.timestamps
    end
  end
end
