require "rails_helper"

RSpec.describe Recipe, type: :model do
  it { is_expected.to have_many(:ingredients) }
  it { is_expected.to have_many(:recipe_ingredients) }

  describe "title field" do
    subject { recipe.valid? }

    let(:recipe) { build(:recipe, title: title) }

    context "when title is nil" do
      let(:title) { nil }

      it { is_expected.to eq(false) }

      it "adds error for name" do
        subject
        expect(recipe.errors.messages[:title]).to eq(["can't be blank"])
      end
    end

    context "when title is empty" do
      let(:title) { "" }

      it { is_expected.to eq(false) }

      it "adds error for name" do
        subject
        expect(recipe.errors.messages[:title]).to eq(["can't be blank"])
      end
    end

    context "when name presence" do
      let(:title) { "onion soup" }

      it { is_expected.to eq(true) }
    end
  end
end
