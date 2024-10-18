require 'rails_helper'

RSpec.describe RecipeIngredient, type: :model do
  it { is_expected.to belong_to(:recipe) }
  it { is_expected.to belong_to(:ingredient) }
end
