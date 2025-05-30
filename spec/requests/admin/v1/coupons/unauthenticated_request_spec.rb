require 'rails_helper'

RSpec.describe "Admin::V1::Coupons without authentication", type: :request do
  context "GET /coupons" do
    let(:url) { "/admin/v1/coupons" }
    let!(:coupons) { create_list(:coupon, 5) }

    before(:each) { get url }
    include_examples "unauthenticated_examples"
  end

  context "POST /coupons" do
    let(:url) { "/admin/v1/coupons" }

    before(:each) { post url }
    include_examples "unauthenticated_examples"
  end

  context "PATCH /coupons" do
    let(:coupon) { create(:coupon) }
    let(:url) { "/admin/v1/coupons/#{coupon.id}" }

    before(:each) { patch url }
    include_examples "unauthenticated_examples"
  end

  context "DELETE /coupons" do
    let!(:coupon) { create(:coupon) }
    let(:url) { "/admin/v1/coupons/#{coupon.id}" }

    before(:each) { delete url }
    include_examples "unauthenticated_examples"
  end
end