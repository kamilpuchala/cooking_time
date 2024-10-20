require "rails_helper"

RSpec.describe Importers::RecipeJsonImporter, type: :service do
  describe "#import" do
    let(:file_path) { Rails.root.join("spec", "fixtures", "recipes.json") }
    let(:parser_service) { double("IngredientParser") }
    subject { described_class.new(file_path).call }

    it "imports recipes and their ingredients from the JSON file and create correct associacions" do
      expect {
        subject { described_class.call(file_path) }
      }.to change(Recipe, :count).by(1)
        .and change(Ingredient, :count).by(3)
        .and change(RecipeIngredient, :count).by(4)
    end

    it "creates the recipe with the correct attributes" do
      subject

      recipe = Recipe.last
      expect(recipe.title).to eq("Curried Cream of Cauliflower Soup")
      expect(recipe.cook_time).to eq(50)
      expect(recipe.prep_time).to eq(15)
      expect(recipe.ratings).to eq(4.61)
      expect(recipe.cuisine).to eq("Asian")
      expect(recipe.category).to eq("Cauliflower Soup")
      expect(recipe.author).to eq("Allyson")
      expect(recipe.image).to eq("https://image.jpg")
      expect(recipe.row_ingredients).to eq([
        "1 head cauliflower, cut into florets",
        "2 tablespoons vegetable oil",
        "1 teaspoon salt",
        "1 cup salt"
      ])
    end
  end
end
