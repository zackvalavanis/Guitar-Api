class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create] # Skip CSRF check for the create action
  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password]) # Ensure you're using bcrypt or similar for password authentication
      token = encode_token(user_id: user.id) # Replace with your JWT encoding method
      render json: { token: token }, status: :created
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  private

  def encode_token(payload)
    JWT.encode(payload, Rails.application.credentials.secret_key_base) # Adjust as needed
  end
end
