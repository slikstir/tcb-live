module Api
  class ApiController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :authenticate_with_token!

    def authenticate_with_token!
      token = request.headers['Authorization'].to_s.remove("Token ").strip
      @current_user = User.find_by(api_token: token)

      unless @current_user
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    end
  end
end
