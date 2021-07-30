module ErrorHandler
  extend ActiveSupport::Concern
  class ApplicationController::Unauthenticated < StandardError; end
  class ActiveRecord::InvalidResource < StandardError; end

  included do
    rescue_from ActiveRecord::RecordInvalid do |e|
      render_error(422, e.record.errors)
    end

    rescue_from ActiveRecord::RecordNotFound do |e|
      render_error(404, e.message)
    end

    rescue_from ActiveRecord::InvalidResource do |e|
      render_error(422, e.message)
    end
  end

  private

  def render_error(code, message)
    render json: { error: message }, status: code
  end
end
