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
        cleaned_ingredient = parser_service.new(cleaned_ingredient).call
        cleaned_ingredient = remove_descriptions(cleaned_ingredient)
        
        singularize(cleaned_ingredient)
      end

      private

      def remove_descriptions(ingredient)
        ingredient.gsub(IngredientDictionary::DESCRIPTIONS_REGEX, "")
      end
      
      def singularize(ingredient)
        ingredient.split.map(&:singularize).uniq.join(' ')
      end
    end
  end
end
