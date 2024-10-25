# CookingTime
#### You can visit it here:   [CookingTime](https://cooking-time.fly.dev)

### Application Overview
CookingTime helps users find the best recipes based on provided ingredients.

---

## Features:

- **Recipe Search by Ingredients**: Finds recipes that match given ingredients.
- **Diet Restrictions**: Filters results based on dietary preferences (e.g., Dairy-Free, Vegetarian).
- **Matching Score**: Returns up to 25 results with a minimum matching score of 25%, sorted in descending order by score. The matching score is calculated as a weighted sum, where each ingredient category contributes based on its individual weight. This score represents the relationship between the cumulative score of matched ingredients and the recipe's maximum possible score, resulting in more accurate recipe ranking.
---

### Key Challenge
- **Initial Data Cleanup**: The unstructured ingredient list from the scraper (33,000 unique entries) presented a significant challenge.
    - **Ingreedy Gem Usage**: Reduced unique ingredients to 19,000.
    - **Custom Parser**: By implementing a custom parser with regex and a dictionary approach, further narrowed down to 9,000 ingredients.
- **Categorization and Scoring**: Ingredients were categorized by food type (e.g., vegetable, meat, additive) and given a score, improving search precision.

---

### Data Structure:

Data is organized across three tables:

1. **Ingredients**:
    - Stores unique ingredients, including details for categorization and ranking.

2. **Recipes**:
    - Contains each recipe's metadata, author, ratings, raw ingredients, and a pre-calculated maximum score.
    - **Rationale for Raw Data**:Keeping the raw list of ingredients allows for potential re-processing and display to customer.

3. **RecipeIngredients**:
    - Join table linking recipes and ingredients.

---

### Search Logic:

1. **Ingredient Search Using `pg_search`**:
    - Enables effective matching despite imperfect ingredient data.

2. **Recipe Lookup**:
    - Finds recipes containing matched ingredients.

3. **Diet-Based Exclusions**:
    - Filters recipes based on diet preferences, utilizing ingredient categories.

---

### Future Improvements:

- **Standardization of Ingredients**: Reducing ingredients to base forms (e.g., "apple," "ham") will enhance search functionality and enable features like prefilled ingredient dropdowns.
    - **Options to Standardize**:
        1. **Admin Panel**: Allows manual ingredient mapping to standard forms. However, new imports would require re-mapping.
        2. **Enhanced Dictionary**: Provides an automated approach but has similar maintenance concerns with new imports.
        3. **Python Microservice with spaCy**: A Python-based microservice could use spaCy’s NLP capabilities for better data cleaning during imports. (there is a ruby gem `ruby-spacy` but unfortunatelly there was a problem with compatibility with app, could need further investigation what will be better approach)
        4. **AWS Comprehend**: Custom model training in AWS Comprehend could improve food-related NER, though no pre-trained food NER models are currently available.
        5. **Ruby-OpenAI Gem**: Initial trials with GPT-3.5 show promise for extracting and categorizing ingredients, with potential for further tuning.

---

### Observations

- **Data Processing and Standardization**: Process of narrowing down unique ingredients from 33,000 to 9,000 is excellent, demonstrating effective handling of unstructured data.
- **Future NLP and AI Potential**: The use of NLP for ingredient standardization is a forward-thinking approach, especially as dataset will grows. Both AWS Comprehend and OpenAI APIs provide pathways for experimentation and future scaling.

---

## Installation

```sh
docker build
docker-compose up -d
docker-compose exec web rake db:migrate
docker-compose exec web rake assets-precompile
docker-compose exec web rake recipes:import #initial file is attached to repo
```


