require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  it { is_expected.to have_many(:recipes) }
  it { is_expected.to have_many(:recipe_ingredients) }
  
  describe "name field" do
    subject { ingredient.valid? }
    
    let(:ingredient) { build(:ingredient, name: name) }
    
    context "when name is nil" do
      let(:name) { nil }
      
      it { is_expected.to eq(false) }
      
      it "adds error for name" do
        subject
        expect(ingredient.errors.messages[:name]).to eq(["can't be blank"])
      end
    end
    
    context "when name is empty" do
      let(:name) { '' }
      
      it { is_expected.to eq(false) }
      
      it "adds error for name" do
        subject
        expect(ingredient.errors.messages[:name]).to eq(["can't be blank"])
      end
    end
    
    context "when name presence" do
      let(:name) { 'onion' }
      
      it { is_expected.to eq(true) }
    end
  end
end
