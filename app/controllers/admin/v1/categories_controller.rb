class Admin::V1::CategoriesController < Admin::V1::ApiController
  def index
    @categories = Category.all
  end

  def create
    @category = Category.new(category_params)
    @category.save!

    render :show, status: :created
  rescue ActiveRecord::RecordInvalid
    render_errors(fields: @category.errors.messages)
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end 
end
