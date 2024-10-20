namespace :recipes do
  desc "Import recipes from JSON file"
  task import: :environment do
    file_path = Rails.root.join("lib", "data", "recipes-en.json")
    importer = Importers::RecipeJsonImporter.new(file_path)
    importer.call
  end
end
