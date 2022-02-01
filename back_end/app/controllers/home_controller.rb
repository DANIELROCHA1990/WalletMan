class HomeController < ApplicationController
  def index
    render json: { message: 'WELCOME!' }, status: 200
  end
end
