require 'rails_helper'

RSpec.describe "Admin::V1::Categories as :admin", type: :request do
  let(:user) { create(:user) }

  context "GET /categories" do
    let(:url) { "/admin/v1/categories" }
    let!(:categories) { create_list(:category, 5) }

    it "returns all categories" do
      get url, headers: auth_header(user: user)

      expect(body_json['categories']).to match_array(categories.as_json(only: %i[id name]))
    end

    it "return success status" do
      get url, headers: auth_header(user: user)

      expect(response).to have_http_status(:ok)
    end
  end

  context "POST /categories" do
    let(:url) { "/admin/v1/categories" }

    context "with valid params" do
      let(:category_params) {
        { category: attributes_for(:category) }.to_json
      }

      it "adds a new category" do
        expect do 
          post url, headers: auth_header(user: user), params: category_params
        end.to change(Category, :count).by(1)
      end

      it "returns last added category" do
        post url, headers: auth_header(user: user), params:category_params
        expect_category = Category.last.as_json(only: %i(id name))

        expect(body_json["category"]).to eq expect_category
      end

      it "returns created status" do
        post url, headers: auth_header(user: user), params:category_params

        expect(response).to have_http_status(:created)
      end
    end
    
    context "with invalid params" do
      let(:invalid_category_params) {
        { category: attributes_for(:category, name: nil) }.to_json
      }

      it "adds a new category" do
        expect do 
          post url, headers: auth_header(user: user), params: invalid_category_params
        end.to_not change(Category, :count)
      end

      it "return error messages" do
        post url, headers: auth_header(user: user), params:invalid_category_params

        expect(body_json["errors"]["fields"]).to have_key("name")
      end

      it "return error message" do
        post url, headers: auth_header(user: user), params:invalid_category_params

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  context "PATCH /categories" do
    let(:category) { create(:category) }
    let(:url) { "/admin/v1/categories/#{category.id}" }

    context "with valid params" do
      let(:new_name) { "New Name" }
      let(:category_params) {
        { category: attributes_for(:category, name: new_name) }.to_json
      }

      it "updates category" do
        patch url, headers: auth_header(user: user), params: category_params
        expect(category.reload.name).to eq new_name
      end

      it "returns updated category" do
        patch url, headers: auth_header(user: user), params: category_params
        expected_category = category.reload.as_json(only: %i(id name))
        expect(body_json["category"]).to eq expected_category
      end

      it "returns status ok" do
        patch url, headers: auth_header(user: user), params: category_params

        expect(response).to have_http_status(:ok)
      end
    end
    
    context "with invalid params" do
      let(:invalid_category_params) {
        { category: attributes_for(:category, name: nil) }.to_json
      }

      it "doesn't updates category" do
        old_name = category.name
        patch url, headers: auth_header(user: user), params: invalid_category_params
        category.reload

        expect(category.name).to eq old_name
      end

      it "return error messages" do
        patch url, headers: auth_header(user: user), params: invalid_category_params

        expect(body_json["errors"]["fields"]).to have_key("name")
      end

      it "return error message" do
        patch url, headers: auth_header(user: user), params: invalid_category_params

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  context "DELETE /categories" do
    let!(:category) { create(:category) }
    let(:url) { "/admin/v1/categories/#{category.id}" }

    it "delete category" do
      expect do
        delete url, headers: auth_header(user: user)
      end.to change(Category, :count).by(-1)
    end

    it "returns no content status" do
      delete url, headers: auth_header(user: user)
      expect(response).to have_http_status(:no_content)
    end

    it "doesn't return any body content" do
      delete url, headers: auth_header(user: user)
      expect(body_json).to_not be_present
    end

    it "doesn't return any body content" do
      product_categories = create_list(:product_category, 3, category: category)
      delete url, headers: auth_header(user: user)
      expect_product_categories = ProductCategory.where(id: product_categories.map(&:id))
      expect(expect_product_categories).to eq []
    end
  end
end
