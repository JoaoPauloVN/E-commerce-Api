class Admin::V1::ApiController < ActionController::API
  include Authenticable

  def render_errors(message: nil, fields: nil, status: :unprocessable_entity)
    errors = {}
    errors[:fields] = fields if fields.present?
    errors[:message] = message.present? || :request_message_error

    render json: { errors: errors }, status: status
  end
end