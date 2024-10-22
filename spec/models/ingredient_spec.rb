require "rails_helper"

RSpec.describe Ingredient, type: :model do
  it { is_expected.to have_many(:recipes) }
  it { is_expected.to have_many(:recipe_ingredients) }

  describe "validations" do
    subject { ingredient.valid? }

    let(:ingredient) { build(:ingredient, name: name, category: category) }

    context "when name is nil" do
      let(:name) { nil }
      let(:category) { "fruit" }

      it { is_expected.to eq(false) }

      it "adds error for name" do
        subject
        expect(ingredient.errors.messages[:name]).to include("can't be blank")
      end
    end

    context "when name is empty" do
      let(:name) { "" }
      let(:category) { "fruit" }

      it { is_expected.to eq(false) }

      it "adds error for name" do
        subject
        expect(ingredient.errors.messages[:name]).to include("can't be blank")
      end
    end

    context "when name is present" do
      let(:name) { "onion" }
      let(:category) { "vegetable" }

      it { is_expected.to eq(true) }
    end

    context "when category is nil" do
      let(:name) { "onion" }
      let(:category) { nil }

      it { is_expected.to eq(false) }

      it "adds error for category" do
        subject
        expect(ingredient.errors.messages[:category]).to include("can't be blank")
      end
    end

    context "when category is not in the allowed list" do
      let(:name) { "onion" }
      let(:category) { "unknown_category" }

      it { is_expected.to eq(false) }

      it "adds error for category" do
        subject
        expect(ingredient.errors.messages[:category]).to include("is not included in the list")
      end
    end

    context "when category is valid" do
      let(:name) { "onion" }
      let(:category) { "vegetable" }

      it { is_expected.to eq(true) }
    end
  end

  describe ".search_by_name" do
    let!(:ingredient1) { create(:ingredient, name: "apple") }
    let!(:ingredient2) { create(:ingredient, name: "banana") }

    it "returns ingredients matching the name" do
      expect(Ingredient.search_by_name("apple")).to include(ingredient1)
    end

    it "returns ingredients with partial matches" do
      expect(Ingredient.search_by_name("apple souce")).to include(ingredient1)
    end

    it "returns ingredients with partial matches" do
      expect(Ingredient.search_by_name("appl")).to_not include(ingredient1)
    end
  end
end
