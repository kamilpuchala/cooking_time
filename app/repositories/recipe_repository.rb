class RecipeRepository
  def search_by_ingredients(input_ingredients: [], dietary_filters: [])
    cleaned_ingredients = cleaned_ingredients(input_ingredients)

    query = Recipe.all
    query = apply_search_by_ingredients(query, cleaned_ingredients) if cleaned_ingredients.present?
    query = apply_dietary_filters(query, dietary_filters) if dietary_filters.present?

    return apply_run_query_when_match_ingredients(query) if cleaned_ingredients.present?
    apply_run_query_when_no_match_ingredients(query)
  end

  private

  def cleaned_ingredients(input_ingredients)
    input_ingredients.map(&:strip).reject(&:blank?).map(&:downcase)
  end

  def apply_search_by_ingredients(query, ingredients)
    query.joins(:ingredients).where(ingredients: {id: matching_ingredient_ids(ingredients)})
  end

  def matching_ingredient_ids(ingredients)
    matching_ingredients = Ingredient.search_by_name(ingredients.join(" "))
    matching_ingredients.pluck(:id)
  end

  def apply_dietary_filters(query, dietary_filters)
    dietary_excluded_ids = Ingredient.where(category: dietary_filters).pluck(:id)
    query.where.not(id: Recipe.joins(:ingredients).where(ingredients: {id: dietary_excluded_ids}).select(:id))
  end

  def apply_run_query_when_match_ingredients(query)
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

  def apply_run_query_when_no_match_ingredients(query)
    query.select(
      "recipes.id",
      "recipes.title",
      "recipes.row_ingredients"
    )
      .order("RANDOM()")
      .limit(25)
  end
end
