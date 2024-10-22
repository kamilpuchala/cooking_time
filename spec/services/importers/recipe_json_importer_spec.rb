require "rails_helper"

RSpec.describe Importers::RecipeJsonImporter, type: :service do
  describe "#call" do
    let(:file_path) { Rails.root.join("spec", "fixtures", "recipes.json") }
    let(:parser_service) { double("IngredientParser") }
    subject { described_class.new(file_path).call }

    it "imports recipes and their ingredients from the JSON file and creates correct associations" do
      expect {
        subject
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

    context "when the JSON file is empty" do
      let(:file_path) { Rails.root.join("spec", "fixtures", "empty_recipes.json") }

      it "does not create any recipes or ingredients" do
        expect { subject }.to_not change(Recipe, :count)
        expect { subject }.to_not change(Ingredient, :count)
      end
    end

    context "when the file does not exist" do
      let(:file_path) { Rails.root.join("spec", "fixtures", "non_existent_recipes.json") }

      it "raises an error" do
        expect { subject }.to raise_error(Errno::ENOENT, /File not found/)
      end
    end

    context "when an ingredient cannot be parsed" do
      before do
        allow_any_instance_of(Parsers::Ingredients::IngredientParser).to receive(:call).and_raise(StandardError, "Parsing error")
      end

      it "logs an error and continues processing other ingredients" do
        expect(Rails.logger).to receive(:error).at_least(:once).with(/RecipeImporter Error: Could not parse ingredient/)
        subject
      end
    end

    context "when image url is blank" do
      before do
        allow(JsonReader).to receive(:new).and_return(double(call: [{"title" => "Recipe without image", "ingredients" => []}]))
      end

      it "creates a recipe without an image" do
        subject
        recipe = Recipe.last
        expect(recipe.image).to be_nil
      end
    end
  end
end
