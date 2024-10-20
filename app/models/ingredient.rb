class Ingredient < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :recipe_ingredients, dependent: :destroy
  has_many :recipes, through: :recipe_ingredients
end
