module Parsers
  module Ingredients
    class IngredientParser
      attr_reader :ingredient_string, :parser_service

      def initialize(ingredient_string, parser_service: IngreedyParser)
        @ingredient_string = ingredient_string
        @parser_service = parser_service
      end

      def call
        return {} if ingredient_string.blank?

        cleaned_ingredient = ingredient_string.downcase.delete(",")
        cleaned_ingredient = parser_service.new(cleaned_ingredient).call
        cleaned_ingredient = remove_descriptions(cleaned_ingredient)

        cleaned_ingredient = singularize(cleaned_ingredient)
        category = find_category(cleaned_ingredient)

        {name: cleaned_ingredient, category: category, score: Ingredient::INGREDIENT_CATEGORY_WITH_SCORE[category]}
      end

      private

      def remove_descriptions(ingredient)
        ingredient.gsub(IngredientDictionary::DESCRIPTIONS_REGEX, "")
      end

      def singularize(ingredient)
        ingredient.split.map(&:singularize).uniq.join(" ")
      end

      def find_category(ingredient_name)
        IngredientDictionary::INGREDIENT_CATEGORIES.each do |category, ingredients|
          ingredients.each do |ingredient|
            return category if ingredient_name.include?(ingredient)
          end
        end
        "unknown"
      end
    end
  end
end
