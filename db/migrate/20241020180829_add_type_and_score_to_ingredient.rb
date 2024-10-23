class AddTypeAndScoreToIngredient < ActiveRecord::Migration[7.1]
  def change
    add_column :ingredients, :category, :string, null: false, default: "unknown"
    add_column :ingredients, :score, :integer, null: false, default: 0
  end
end
