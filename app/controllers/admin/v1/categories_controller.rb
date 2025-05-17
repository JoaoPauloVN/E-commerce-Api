class Admin::V1::CategoriesController < Admin::V1::ApiController
  before_action :load_category, only: [:update, :destroy]

  def index
    @categories = Category.all
  end

  def create
    @category = Category.new(category_params)
    save_category(:created)
  end

  def update
    @category.attributes = category_params
    save_category(:ok)
  end

  def destroy
    @category.destroy!
    head :no_content
  rescue ActiveRecord::RecordNotDestroyed
    render_errors(fields: @category.errors.messages)
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end 

  def save_category(status)
    @category.save!

    render :show, status: status
  rescue ActiveRecord::RecordInvalid
    render_errors(fields: @category.errors.messages)
  end

  def load_category
    @category = Category.find(params[:id])
  end
end
