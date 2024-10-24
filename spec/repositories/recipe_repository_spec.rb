require "rails_helper"

RSpec.describe RecipeRepository, type: :model do
  let(:repository) { RecipeRepository.new }
  let!(:ingredient_1) { create(:ingredient, name: "tomato", score: 6, category: "vegetable") }
  let!(:ingredient_2) { create(:ingredient, name: "basil", score: 1, category: "condiment") }
  let!(:ingredient_3) { create(:ingredient, name: "cheese", score: 4, category: "dairy") }
  let!(:ingredient_4) { create(:ingredient, name: "chicken", score: 8, category: "meat") }

  let!(:recipe_1) do
    create(:recipe,
      title: "Tomato Basil Salad",
      row_ingredients: [ingredient_1.name, ingredient_2.name],
      max_score: ingredient_1.score + ingredient_2.score)
  end

  let!(:recipe_2) do
    create(:recipe,
      title: "Cheese Pizza",
      row_ingredients: [ingredient_1.name, ingredient_3.name],
      max_score: ingredient_1.score + ingredient_3.score)
  end

  let!(:recipe_3) do
    create(:recipe,
      title: "Chicken Parmesan",
      row_ingredients: [ingredient_3.name, ingredient_4.name],
      max_score: ingredient_3.score + ingredient_4.score)
  end

  before do
    recipe_1.ingredients << [ingredient_1, ingredient_2]
    recipe_2.ingredients << [ingredient_1, ingredient_3]
    recipe_3.ingredients << [ingredient_3, ingredient_4]
  end

  describe "#search_by_ingredients" do
    context "when matching ingredients are found" do
      it "returns recipes ordered by highest matching percentage" do
        results = repository.search_by_ingredients(input_ingredients: ["tomato", "cheese"])

        expect(results.length).to eq(3)
        expect(results.first.id).to eq(recipe_2.id)
        expect(results.first.read_attribute("matching_percentage").to_f).to eq(100.0)
      end

      it "ignores blank entries and applies filtering based on valid ingredients" do
        results = repository.search_by_ingredients(input_ingredients: ["", "tomato"])

        expect(results.length).to eq(2)
        expect(results).to include(recipe_1, recipe_2)
        expect(results.first.read_attribute("matching_percentage").to_f).to eq(85.71)
        expect(results.second.read_attribute("matching_percentage").to_f).to eq(60.0)
      end
    end

    context "when no matching ingredients are found" do
      it "returns no recipes" do
        results = repository.search_by_ingredients(input_ingredients: ["apple"])

        expect(results).to be_empty
      end
    end

    context "when dietary filters are applied" do
      it "excludes recipes with ingredients from excluded dietary categories" do
        results = repository.search_by_ingredients(input_ingredients: ["cheese", "tomato"], dietary_filters: ["dairy"])

        expect(results.length).to eq(1)
        expect(results).to eq([recipe_1])
      end

      it "excludes multiple recipes based on dietary filters" do
        results = repository.search_by_ingredients(input_ingredients: ["cheese", "chicken"], dietary_filters: ["dairy", "meat"])

        expect(results).to be_empty
      end
    end

    context "when ingredient scores result in a low matching percentage" do
      it "only returns recipes with matching percentage above 25%" do
        results = repository.search_by_ingredients(input_ingredients: ["basil"])

        expect(results).to be_empty
      end
    end

    context "when input ingredients are empty or blank" do
      it "returns random recipes when multiple empty ingredients are provided" do
        results = repository.search_by_ingredients(input_ingredients: ["", ""], dietary_filters: ["dairy"])

        expect(results.length).to eq(1)
        expect(results).to include(recipe_1)
        expect(results.first.read_attribute("matching_percentage")).to be_nil
      end
    end

    context "when both input ingredients and dietary filters are empty" do
      it "returns recipes in random order without any filtering" do
        results = repository.search_by_ingredients(input_ingredients: [""], dietary_filters: [])

        expect(results.length).to eq(3)
        expect(results).to include(recipe_1, recipe_2, recipe_3)
        expect(results.first.read_attribute("matching_percentage")).to be_nil
      end
    end
  end
end
