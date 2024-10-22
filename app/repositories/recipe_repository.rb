class RecipeRepository
  def search_by_ingredients(input_ingredients:, dietary_filters: [])
    matching_ingredient_ids = matching_ids(input_ingredients)

    if matching_ingredient_ids.empty?
      Recipe.none
    else
      query = Recipe.joins(:ingredients).where(ingredients: {id: matching_ingredient_ids})
      query = apply_dietary_filters(query, dietary_filters) if dietary_filters.present?
      query.select(
        "recipes.id",
        "recipes.title",
        "recipes.row_ingredients",
        "ROUND(((SUM(ingredients.score)::float / NULLIF(recipes.max_score, 0)) * 100)::numeric, 2) AS matching_percentage"
      )
        .group("recipes.id")
        .having("(SUM(ingredients.score)::float / NULLIF(recipes.max_score, 0)) * 100 > 25")
        .order("matching_percentage DESC")
        .limit(25)
    end
  end

  private

  def matching_ids(input_ingredients)
    input_ingredients = input_ingredients.map(&:strip).map(&:downcase)
    matching_ingredients = Ingredient.search_by_name(input_ingredients.join(" "))
    matching_ingredients.pluck(:id)
  end

  def apply_dietary_filters(query, dietary_filters)
    dietary_excluded_ids = Ingredient.where(category: dietary_filters).pluck(:id)
    query.where.not(id: Recipe.joins(:ingredients).where(ingredients: {id: dietary_excluded_ids}).select(:id))
  end
end
