class Admin::V1::CategoriesController < Admin::V1::ApiController
  def index
    @categories = Category.all
  end

  def create
    @category = Category.new(category_params)
    save_category(:created)
  end

  def update
    @category = Category.find(params[:id])
    @category.attributes = category_params
    save_category(:ok)
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
end
