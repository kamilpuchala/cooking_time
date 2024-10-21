class RecipesController < ApplicationController
  def index
    if params[:ingredients].blank?
      @recipes = Recipe.order('RANDOM()').limit(25)
    else
      @recipes = ::RecipeRepository.new.search_by_ingredients(params[:ingredients],
                                                          dietary_filters: params[:dietary_filters])
    end
  end
end
