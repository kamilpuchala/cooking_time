module Importers
  class RecipeJsonImporter
    attr_reader :file_path, :parser_service

    def initialize(file_path, parser_service: Parsers::Ingredients::IngredientParser)
      @file_path = file_path
      @parser_service = parser_service
    end

    def call
      require "json"
      file = File.read(file_path)
      recipes_data = JSON.parse(file)

      recipes_data.each_with_index do |recipe_data, index|
        ActiveRecord::Base.transaction do
          recipe = create_recipe(recipe_data)
          process_ingredients(recipe, recipe_data["ingredients"])
        end
      end
    end

    private

    def create_recipe(recipe_data)
      Recipe.create!(
        title: recipe_data["title"],
        cook_time: recipe_data["cook_time"],
        prep_time: recipe_data["prep_time"],
        ratings: recipe_data["ratings"],
        cuisine: recipe_data["cuisine"],
        category: recipe_data["category"],
        author: recipe_data["author"],
        image: recipe_data["image"],
        row_ingredients: recipe_data["ingredients"]
      )
    end

    def process_ingredients(recipe, ingredients_data)
      ingredients_data.each do |ingredient_data|
        ingredient_name = parse_ingredient(ingredient_data)
        next if ingredient_name.blank?

        ingredient = Ingredient.find_or_create_by(name: ingredient_name)
        RecipeIngredient.create!(recipe: recipe, ingredient: ingredient)
      end
    end

    def parse_ingredient(ingredient_data)
      parser_service.new(ingredient_data, parser_service: Parsers::Ingredients::IngreedyParser).call
    rescue => e
      Rails.logger.error("RecipeImporter Error: Could not parse ingredient '#{ingredient_data}'. Error: #{e.message}")
      ingredient_data
    end
  end
end
