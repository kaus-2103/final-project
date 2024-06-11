class Api::V1::CollectionsController < ApplicationController
    before_action :authenticate_with_token
  
    def index
      render json: current_user.collections
    end
  
    def show
      collection = current_user.collections.find(params[:id])
      render json: collection
    end
  
    private
  
    def authenticate_with_token
      token = request.headers['Authorization']
      user = ApiToken.find_by(token: token)&.user
      head :unauthorized unless user
      @current_user = user
    end
  
    def current_user
      @current_user
    end
  end
  