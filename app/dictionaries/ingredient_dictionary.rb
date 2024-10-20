module IngredientDictionary
  unless defined?(DESCRIPTIONS)
    DESCRIPTIONS = [
      "thin-sliced", "skinless", "boneless", "diced", "fresh", "melted", "divided", "cut into bite size pieces", "ground",
      "cooked", "crushed", "chopped", "warm", "sliced", "mashed", "cut", "small", "medium", "large", "halved", "peeled",
      "seeded", "grated", "shredded", "minced", "dried", "freshly", "finely", "or", "if", "more", "to", "for", "taste",
      "topping", "drained", "thinly", "and", "half", "crumbled", "as", "needed", "frozen", "prepered", "into strips",
      "extra-virgin", "degree", "degrees", "softened", "at", "room", "temperature", "optional", "such", "as", "into",
      "chunks", "cold", "hot", "warm", "temp", "(", ")", "flavor", "any", "()", "carton", "%", "cooled", "uncooked",
      "cooked", "beaten", "lightly", " - ", "cored", "coarsely", "chopped", "lukewarm", "jumbo", "thawed", "florets",
      "head"
    ]
  end

  unless defined?(UNITS)
    UNITS = %w[
      cups cup tablespoons tablespoon teaspoons teaspoon pounds pound oz ounces ounce g grams gram kg kilograms kilogram
      ml milliliters milliliter l liters liter can cans package packages bottle bottles piece pieces clove cloves
    ]
  end

  DESCRIPTIONS_REGEX = /\b(#{DESCRIPTIONS.map { |d| Regexp.escape(d) }.join("|")})\b/i
  UNITS_REGEX = /\b\d+(\.\d+)?\s*(#{UNITS.map { |u| Regexp.escape(u) }.join("|")})?\b/i
end
