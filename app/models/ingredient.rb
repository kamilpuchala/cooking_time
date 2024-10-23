class Ingredient < ApplicationRecord
  INGREDIENT_CATEGORY_WITH_SCORE = {
    "unknown" => 3,
    "fruit" => 6,
    "vegetable" => 6,
    "dairy" => 4,
    "meat" => 8,
    "condiment" => 1,
    "additive" => 3
  }.freeze

  validates :name, presence: true, uniqueness: true
  validates :category, presence: true, inclusion: {in: INGREDIENT_CATEGORY_WITH_SCORE.keys}

  has_many :recipe_ingredients, dependent: :destroy
  has_many :recipes, through: :recipe_ingredients

  include PgSearch::Model

  pg_search_scope :search_by_name,
    against: :name,
    using: {
      tsearch: {prefix: false, any_word: true},
      trigram: {threshold: 0.9}
    },
    ranked_by: ":trigram"
end
