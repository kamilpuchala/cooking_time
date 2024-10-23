FactoryBot.define do
  factory :ingredient do
    name { Faker::Food.ingredient }
    category { Ingredient::INGREDIENT_CATEGORY_WITH_SCORE.keys.sample }
    score { category }
  end
end
