module Importers
  class RecipeJsonImporter
    attr_reader :file_path, :parser_service

    def initialize(file_path, parser_service: Parsers::Ingredients::IngredientParser)
      @file_path = file_path
      @parser_service = parser_service
    end

    def call
      raise Errno::ENOENT, "File not found: #{file_path}" unless File.exist?(file_path)

      recipes_data = JsonReader.new(file_path).call
      import_recipes(recipes_data)
    end

    private

    def import_recipes(recipes_data)
      recipes_data.each do |recipe_data|
        ActiveRecord::Base.transaction do
          ingredients = process_ingredients(recipe_data["ingredients"])
          recipe = create_recipe!(recipe_data: recipe_data, max_score: ingredients.sum(&:score))
          recipe.ingredients << ingredients
        end
      end
    end

    def create_recipe!(recipe_data:, max_score:)
      Recipe.create!(
        title: recipe_data["title"],
        cook_time: recipe_data["cook_time"],
        prep_time: recipe_data["prep_time"],
        ratings: recipe_data["ratings"],
        cuisine: recipe_data["cuisine"],
        category: recipe_data["category"],
        author: recipe_data["author"],
        image: parsed_image_url(recipe_data["image"]),
        row_ingredients: recipe_data["ingredients"],
        max_score: max_score
      )
    end

    def parsed_image_url(image_url)
      return if image_url.blank?

      url = image_url.split("url=").last
      URI.decode_www_form_component(url)
    end

    def process_ingredients(ingredients_data)
      ingredients_data.map do |ingredient_data|
        parsed_ingredient = parse_ingredient(ingredient_data)
        next if parsed_ingredient.blank? || parsed_ingredient[:name].blank?

        Ingredient.where(parsed_ingredient).first_or_create
      end.compact
    end

    def parse_ingredient(ingredient_data)
      parser_service.new(ingredient_data, parser_service: Parsers::Ingredients::IngreedyParser).call
    rescue => e
      Rails.logger.error("RecipeImporter Error: Could not parse ingredient '#{ingredient_data}'. Error: #{e.message}")
      {name: nil}
    end
  end
end
