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
      "head", "smashed", "unsweetened", "cups", "cup", "tablespoons", "tablespoon", "teaspoons", "teaspoon", "pounds",
      "pound", "oz", "ounces", "ounce", "g", "grams", "gram", "kg", "kilograms", "kilogram", "ml", "milliliters",
      "milliliter", "l", "liters", "liter", "can", "cans", "package", "packages", "bottle", "bottles", "piece",
      "pieces", "clove", "cloves", "evaporated", "fat-free", "low-fat", "reduced-fat", "nonfat", "fat", "brushing",
      "until", "frothy", "separatedwhite", "reserved", "ripe", "cubed", "quarters", "squeezed", "packed", "plus",
      "drizzling", "slices", "in", "stripped", "raw", "light", "fat", "roughly", "prepared", "prepare", "canned",
      "removed", "zested", "organic", "sifted", "wedges", "hard", "boiled", "well", "with", "hard", "soft", "wash",
      "wide", "inch", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "size", "strip", "strips", "bite", "sized",
      "halve", "rosting", "scapes", "scape"
    ]
  end
  
  DESCRIPTIONS_REGEX = /(?:\(\s*)?\b(#{DESCRIPTIONS.map { |d| Regexp.escape(d) }.join("|")})\b(?:\s*\))?/i
 
end
