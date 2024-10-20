module Parsers
  module Ingredients
    class IngreedyParser
      attr_reader :ingredient_string

      def initialize(ingredient_string)
        @ingredient_string = ingredient_string
      end

      def call
        Ingreedy.parse(ingredient_string).ingredient
      rescue => e
        Rails.logger.error("IngreedyParser Error: #{e.message}")
        ingredient_string
      end
    end
  end
end
