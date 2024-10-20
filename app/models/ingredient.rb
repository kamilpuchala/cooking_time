class Ingredient < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :recipe_ingredients, dependent: :destroy
  has_many :recipes, through: :recipe_ingredients
  
  include PgSearch::Model
  
  pg_search_scope :search_by_name,
                  against: :name,
                  using: {
                    tsearch: { prefix: false, any_word: true },
                    trigram: { threshold: 0.9 }
                  },
    ranked_by: ":trigram"
end
