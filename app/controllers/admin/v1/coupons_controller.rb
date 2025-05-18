class Admin::V1::CouponsController < Admin::V1::ApiController
  before_action :load_coupon, only: [:update, :destroy]

  def index
    @coupons = Coupon.all
  end

  def create
    @coupon = Coupon.create(coupon_params)
    save(:created)
  end

  def update
    @coupon.attributes = coupon_params
    save()
  end

  def destroy
    @coupon.destroy!
    head :no_content
  rescue ActiveRecord::RecordNotDestroyed
    render_errors(fields: @coupon.errors.messages)
  end

  private

  def coupon_params
    params.require(:coupon).permit(:code, :status, :discount_value, :due_date)
  end

  def save(status = :ok)
    @coupon.save!

    render :show, status: status
  rescue ActiveRecord::RecordInvalid
    render_errors(fields: @coupon.errors.messages)
  end

  def load_coupon
    @coupon = Coupon.find(params[:id])
  end
end
