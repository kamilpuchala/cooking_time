class AddMaxScoreToRecipe < ActiveRecord::Migration[7.1]
  def change
    add_column :recipes, :max_score, :integer, null: false, default: 0
  end
end
