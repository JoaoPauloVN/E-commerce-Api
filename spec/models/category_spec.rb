# spec/models/category_spec.rb
require 'rails_helper'

RSpec.describe Category, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name).case_insensitive }

  it { is_expected.to have_many(:product_categories).dependent(:destroy) }
  it { is_expected.to have_many(:products).through(:product_categories) }

  it_behaves_like "name_searchable_concern", :category
  it_behaves_like "pagination_concern", :category
end