class RecipesController < ApplicationController
  def index
    @recipes = if params[:ingredients].blank? && params[:dietary_filters].blank?
      Recipe.order("RANDOM()").limit(25)
    else
      RecipeRepository.new.search_by_ingredients(input_ingredients: params[:ingredients], dietary_filters: params[:dietary_filters])
    end

    respond_to do |format|
      format.html
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    @back_params = {ingredients: params[:ingredients], dietary_filters: params[:dietary_filters]}
  end
end
