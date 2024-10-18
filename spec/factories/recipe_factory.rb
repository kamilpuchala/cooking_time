FactoryBot.define do
  factory :recipe do
    title { Faker::Food.disch }
    cook_time { 15 }
    prep_time { 20 }
    ratings { 4.6 }
    cuisine { Faker::Food.ethnic_category }
    category { Faker::Food.ethnic_category }
    author { Faker::Name.name }
    image { 'image.jpg' }
    row_ingredients { [Faker::Food.fruits ] }
  end
end
