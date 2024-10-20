class RecipesController < ApplicationController
  def index
    if params[:ingredients].blank?
      @recipes = Recipe.last(10)
    else
      input_ingredients = params[:ingredients].map(&:strip).map(&:downcase)
      
      matching_ingredients = Ingredient.search_by_name(input_ingredients.join(' '))
      @recipes = Recipe.joins(:ingredients)
                       .where(ingredients: { id: matching_ingredients.pluck(:id) })
                       .select('recipes.*, COUNT(ingredients.id) as ingredient_match_count')
                       .group('recipes.id')
                       .order('ingredient_match_count DESC')
    
    end
  end
end
