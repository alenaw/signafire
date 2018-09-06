class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def render_error(status_code, message)
    render json: { error: message }.to_json, status: status_code
  end
end
