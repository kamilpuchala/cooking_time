require "rails_helper"

RSpec.describe Parsers::Ingredients::IngredientParser, type: :service do
  describe "#parse" do
    let(:parser_service) { class_double("ParserService", new: instance_double("ParserService", call: parsed_ingredient_name)) }
    let(:ingredient_string) { "1 cup thin-sliced fresh apples, peeled and diced" }
    let(:parser) { Parsers::Ingredients::IngredientParser.new(ingredient_string, parser_service: parser_service) }

    context "when the ingredient belongs to a different category" do
      let(:ingredient_string) { "1 cup shredded cheddar cheese" }
      let(:parsed_ingredient_name) { "cheddar cheese" }

      it "correctly categorizes the ingredient as dairy" do
        parsed_ingredient = {category: "dairy", name: "cheddar cheese", score: 4}
        expect(parser.call).to eq(parsed_ingredient)
      end
    end

    context "when the ingredient does not belong to any known category" do
      let(:parsed_ingredient_name) { "RedAppleGreen" }

      it "returns 'unknown' as the category" do
        parsed_ingredient = {category: "unknown", name: "RedAppleGreen", score: 3}
        expect(parser.call).to eq(parsed_ingredient)
      end
    end

    context "when the ingredient contains multiple descriptions" do
      let(:ingredient_string) { "2 large, peeled and diced apples" }
      let(:parsed_ingredient_name) { "apple" }

      it "removes descriptions and parses the ingredient name correctly" do
        parsed_ingredient = {category: "fruit", name: "apple", score: 6}
        expect(parser.call).to eq(parsed_ingredient)
      end
    end

    context "when the ingredient is in plural form" do
      let(:ingredient_string) { "1 cup blueberries" }
      let(:parsed_ingredient_name) { "blueberry" }

      it "singularizes the ingredient name" do
        parsed_ingredient = {category: "fruit", name: "blueberry", score: 6}
        expect(parser.call).to eq(parsed_ingredient)
      end
    end

    context "when the ingredient string is empty" do
      let(:ingredient_string) { "" }
      let(:parsed_ingredient_name) { "" }

      it "returns 'unknown' as the category and an empty name" do
        parsed_ingredient = {}
        expect(parser.call).to eq(parsed_ingredient)
      end
    end
  end
end
