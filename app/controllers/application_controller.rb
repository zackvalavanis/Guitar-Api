class ApplicationController < ActionController::Base
  # Skip CSRF protection for JSON requests
  protect_from_forgery with: :exception, unless: -> { request.format.json? }

  # Method to find the current user from the JWT token in the Authorization header
  def current_user
    auth_headers = request.headers["Authorization"]
    if auth_headers.present?
      token = auth_headers[/(?<=\A(Bearer ))\S+\z/]
      if token
        begin
          decoded_token = JWT.decode(
            token,
            Rails.application.credentials.fetch(:secret_key_base),
            true,
            { algorithm: "HS256" }
          )
          User.find_by(id: decoded_token[0]["user_id"])
        rescue JWT::ExpiredSignature
          nil # Token has expired
        rescue JWT::DecodeError
          nil # Token is invalid
        end
      end
    end
  end

  # Method to authenticate user for protected routes
  def authenticate_user
    unless current_user
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
