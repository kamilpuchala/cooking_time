require "rails_helper"

RSpec.describe Parsers::Ingredients::IngredientParser, type: :service do
  describe "#parse" do
    it "parses the cleaned ingredient using the parser_service" do
      ingredient_string = "1 cup thin-sliced fresh apples, peeled and diced"
      cleaned_ingredient = "apples"

      parser = Parsers::Ingredients::IngredientParser.new(ingredient_string)

      expect(parser.call).to eq(cleaned_ingredient)
    end
  end
end
