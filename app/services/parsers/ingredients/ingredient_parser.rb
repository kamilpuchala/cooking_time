module Ingredients
  class IngredientParser
    attr_reader :ingredient_string, :parser_service
    
    def initialize(ingredient_string, parser_service: IngreedyParser.new)
      @ingredient_string = ingredient_string
      @parser_service = parser_service
    end
    
    def parse
      cleaned_ingredient = ingredient_string.downcase.gsub(',', '')
      cleaned_ingredient = remove_quantities(cleaned_ingredient)
      cleaned_ingredient = remove_descriptions(cleaned_ingredient)
      cleaned_ingredient = cleaned_ingredient.strip
      
      parser_service.parse(cleaned_ingredient)
    end
    
    private
    
    def remove_descriptions(ingredient)
      ingredient.gsub(IngredientDictionary::DESCRIPTIONS_REGEX, '')
    end
    
    def remove_quantities(ingredient)
      ingredient.gsub(IngredientDictionary::UNITS_REGEX, '')
    end
  end
end
