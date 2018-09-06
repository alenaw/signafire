class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def error_response(message)
    { error: message }.to_json
  end
end
