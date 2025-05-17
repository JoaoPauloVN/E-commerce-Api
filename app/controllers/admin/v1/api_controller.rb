class Admin::V1::ApiController < ActionController::API
  class ForbiddenAccess < StandardError; end
  
  include Authenticable

  before_action :restrict_access_for_admin

  def render_errors(message: nil, fields: nil, status: :unprocessable_entity)
    errors = {}
    errors[:fields] = fields if fields.present?
    errors[:message] = message.presence || :request_message_error

    render json: { errors: errors }, status: status
  end

  rescue_from ForbiddenAccess do
    render_errors(message: "Forbidden access", status: :forbidden)
  end

  private
   
  def restrict_access_for_admin
    raise ForbiddenAccess unless current_user.admin?
  end
end