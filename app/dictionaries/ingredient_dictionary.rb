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
      "pieces", "evaporated", "fat-free", "low-fat", "reduced-fat", "nonfat", "fat", "brushing",
      "until", "frothy", "separatedwhite", "reserved", "ripe", "cubed", "quarters", "squeezed", "packed", "plus",
      "drizzling", "slices", "in", "stripped", "raw", "light", "fat", "roughly", "prepared", "prepare", "canned",
      "removed", "zested", "organic", "sifted", "wedges", "hard", "boiled", "well", "with", "hard", "soft", "wash",
      "wide", "inch", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "size", "strip", "strips", "bite", "sized",
      "halve", "rosting", "scapes", "scape"
    ]
  end
  
  DESCRIPTIONS_REGEX = /(?:\(\s*)?\b(#{DESCRIPTIONS.map { |d| Regexp.escape(d) }.join("|")})\b(?:\s*\))?/i
  
  unless defined?(INGREDIENT_CATEGORIES)
    INGREDIENT_CATEGORIES = {
      "dairy" => ['milk', 'yogurt', 'butter', 'cheese', 'cream', 'buttermilk','ghee', 'mozzarella', 'chedar', 'margarine'],
      "meat" => ['chicken', 'turkey', 'beef', 'pork', 'lamb', 'veal', 'bacon', 'ham', 'sausage', 'duck', 'goose', 'rabbit',
                 'salmon', 'tuna', 'trout', 'halibut', 'cod', 'bass', 'mackerel', 'sardine', 'anchovy', 'herring', 'shrimp',
                 'prawn', 'crab', 'lobster', 'clam', 'mussel', 'scallop', 'squid', 'octopus', 'snail', 'oyster', 'meat',
                 'meatball'],
      "vegetable" => [
        'onion', 'tomato', 'cucumber', 'carrot', 'broccoli', 'spinach', 'lettuce', 'vegetable', 'mushroom',
        'zucchini', 'eggplant', 'cauliflower', 'cabbage', 'celery',  'ginger', 'green beans', 'pumpkin',
        'bean', 'potato', 'wheat', 'corn', 'fig', 'jalapeno'
      ],
      "fruit" => [
        'apple', 'banana', 'orange', 'lemon', 'lime', 'strawberry', 'blueberry', 'grape', 'pineapple', 'peach', 'pear',
        'mango', 'watermelon', 'cherry', 'kiwi', 'plum', 'raspberry', 'blackberry', 'cranberry', 'coconut', 'fruit'
      ],
      "condiment" => ['salt', 'pepper', 'cinnamon', 'nutmeg', 'paprika', 'oregano', 'basil', 'thyme', 'rosemary', 'cumin',
              'turmeric', 'ginger', 'cloves', 'cardamom', 'coriander', 'dill', 'fennel', 'bay leaves', 'mustard seeds',
              'saffron', 'vanilla', 'chili powder', 'garlic', 'oil', 'vinegar', 'sugar', 'honey',
              'ketchup', 'mayonnaise', 'mustard', 'horseradish', 'salsa', 'barbecue sauce', 'worcestershire sauce',
               'sauce', 'syrup', 'jam', 'jelly', 'relish', 'chutney', 'pesto', 'tahini', 'wasabi', 'hoisin',
                      'coca', 'almond', 'hazelnut', 'parsley', 'pepper', 'cayenne', 'chili', 'curry', 'soy', 'sherry'
      ],
      "additive" => ['pasta', 'noodle', 'spaghetti', 'fettuccine', 'macaroni', 'lasagna', 'penne', 'ramen', 'udon', 'soba',
                  'lentils', 'chickpeas', 'black beans', 'kidney beans', 'navy beans', 'pinto beans', 'peas', 'soybeans',
                  'bread', 'baguette', 'bun', 'roll', 'tortilla', 'pita', 'naan', 'sourdough', 'flatbread', 'flour',
                  'tofu', 'egg', 'beer', 'wine', 'water', 'biscuit', 'seed', 'chocolate', 'oatmeal', 'granola', 'gelatin',
                     'cake', 'baking', 'quinoa', 'brandy', 'rum', 'pancake', 'juice', 'rice', 'soda', 'tea', 'coffee',
                     'taco', 'fish sauce'
      ]
    }
  end
end
