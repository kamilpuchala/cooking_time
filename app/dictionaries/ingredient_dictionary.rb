module IngredientDictionary
  DESCRIPTIONS = [
    "thin-sliced", "skinless", "boneless", "diced", "fresh", "melted", "divided", "cut into bite size pieces", "ground",
    "cooked", "crushed", "chopped", "warm", "sliced", "mashed", "cut", "small", "medium", "large", "halved", "peeled",
    "seeded", "grated", "shredded", "minced", "dried", "freshly", "finely", "or", "more", "to", "for", "taste",
    "topping", "drained","thinly", "and", "half", "crumbled", "as", "needed", "frozen", "prepered", "into strips",
    "extra-virgin"
  ]
  
  UNITS == %w[
  cups cup tablespoons tablespoon teaspoons teaspoon pounds pound oz ounces ounce g grams gram kg kilograms kilogram
   ml milliliters milliliter l liters liter can cans package packages bottle bottles
]
  
  DESCRIPTIONS_REGEX = /\b(#{DESCRIPTIONS.map { |d| Regexp.escape(d) }.join('|')})\b/i
  UNITS_REGEX = /^\s*\d+(\.\d+)?\s*\b(#{UNITS.map { |u| Regexp.escape(u) }.join('|')})\b\s*/i
end
