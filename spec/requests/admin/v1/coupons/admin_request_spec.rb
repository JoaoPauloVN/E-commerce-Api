require 'rails_helper'

RSpec.describe "Admin::V1::Coupons as :admin", type: :request do
  let(:user) { create(:user) }
  let(:fields) { %i[id code status discount_value due_date] }

  context "GET /coupons" do
    let(:url) { "/admin/v1/coupons" }
    let!(:coupons) { create_list(:coupon, 5) }

    before { get url, headers: auth_header(user: user) }

    it "returns all coupons with correct data" do
      expected_coupons = coupons.as_json(only: fields)
      expect(body_json['coupons']).to match_array(expected_coupons)
    end

    it "returns success status" do
      expect(response).to have_http_status(:ok)
    end
  end

  context "POST /coupons" do
    let(:url) { "/admin/v1/coupons" }

    context "with valid params" do
      let(:coupon_params) {
        { coupon: attributes_for(:coupon) }.to_json
      }

      it "adds a new coupon" do
        expect do 
          post url, headers: auth_header(user: user), params: coupon_params
        end.to change(Coupon, :count).by(1)
      end

      it "returns last added coupon" do
        post url, headers: auth_header(user: user), params:coupon_params
        expect_coupon = Coupon.last.as_json(only: fields)

        expect(body_json["coupon"]).to eq expect_coupon
      end

      it "returns created status" do
        post url, headers: auth_header(user: user), params:coupon_params
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid params" do
      let(:invalid_coupon_params) {
        { coupon: attributes_for(:coupon, code: nil, status: nil, discount_value: nil, due_date: nil) }.to_json
      }

      it "adds a new coupon" do
        expect do 
          post url, headers: auth_header(user: user), params: invalid_coupon_params
        end.to_not change(Coupon, :count)
      end

      it "return error messages" do
        post url, headers: auth_header(user: user), params:invalid_coupon_params

        fields[1..].each do |field|
          expect(body_json["errors"]["fields"]).to have_key(field.to_s)
        end
      end

      it "return error message" do
        post url, headers: auth_header(user: user), params:invalid_coupon_params

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  context "PATCH /coupons" do
    let(:coupon) { create(:coupon) }
    let(:url) { "/admin/v1/coupons/#{coupon.id}" }

    context "with valid params" do
      let(:new_code) { Faker::Commerce.unique.promotion_code(digits: 6) }
      let(:coupon_params) {
        { coupon: attributes_for(:coupon, code: new_code) }.to_json
      }

      before { patch url, headers: auth_header(user: user), params: coupon_params }

      it "updates coupon" do
        expect(coupon.reload.code).to eq new_code
      end

      it "returns updated coupon" do
        expected_coupon = coupon.reload.as_json(only: fields)
        expect(body_json["coupon"]).to eq expected_coupon
      end

      it "returns status ok" do
        expect(response).to have_http_status(:ok)
      end
    end
    
    context "with invalid params" do
      let(:invalid_coupon_params) {
        { coupon: attributes_for(:coupon, code: nil, status: nil, discount_value: nil, due_date: nil) }.to_json
      }

      before { patch url, headers: auth_header(user: user), params: invalid_coupon_params }

      it "doesn't updates coupon" do
        old_code = coupon.code 
        coupon.reload

        expect(coupon.code).to eq old_code
      end

      it "return error messages" do
        fields[1..].each do |field|
          expect(body_json["errors"]["fields"]).to have_key(field.to_s)
        end
      end

      it "return error message" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  context "DELETE /coupons" do
    let!(:coupon) { create(:coupon) }
    let(:url) { "/admin/v1/coupons/#{coupon.id}" }

    it "delete coupon" do
      expect do
        delete url, headers: auth_header(user: user)
      end.to change(Coupon, :count).by(-1)
    end

    it "returns no content status" do
      delete url, headers: auth_header(user: user)
      expect(response).to have_http_status(:no_content)
    end

    it "doesn't return any body content" do
      delete url, headers: auth_header(user: user)
      expect(body_json).to_not be_present
    end
  end
end