module Parsers
  module Ingredients
    class IngredientParser
      attr_reader :ingredient_string, :parser_service

      def initialize(ingredient_string, parser_service: IngreedyParser)
        @ingredient_string = ingredient_string
        @parser_service = parser_service
      end

      def call
        cleaned_ingredient = ingredient_string.downcase.delete(",")
        cleaned_ingredient = remove_quantities(cleaned_ingredient)
        cleaned_ingredient = remove_descriptions(cleaned_ingredient)
        cleaned_ingredient = cleaned_ingredient.strip

        (cleaned_ingredient.split.length == 1) ? cleaned_ingredient : parser_service.new(cleaned_ingredient).call
      end

      private

      def remove_descriptions(ingredient)
        ingredient.gsub(IngredientDictionary::DESCRIPTIONS_REGEX, "")
      end

      def remove_quantities(ingredient)
        ingredient.gsub(IngredientDictionary::UNITS_REGEX, "")
      end
    end
  end
end
