class GuitarsController < ApplicationController
  before_action :authenticate_user  # This will ensure that all actions require authentication

  def index 
    @guitars = current_user.guitars
    render :index
  end

  def show
    @guitar = Guitar.find_by(id: params[:id])
    render :show 
  end 

  def create
    @guitar = Guitar.new(
      name: params[:name], 
      year: params[:year], 
      price: params[:price],
      user_id: current_user.id
    )
    @guitar.save
    render :show
  end 

  def update
    @guitar = Guitar.find_by(id: params[:id])
    @guitar.update(
      name: params[:name] || @guitar.name,
      year: params[:year] || @guitar.year,
      price: params[:price] || @guitar.price,
      user_id: current_user.id
    )
    render :show
  end 

  def destroy 
    @guitar = Guitar.find_by(id: params[:id])
    @guitar.destroy 
    render json: { message: 'The guitar post has been deleted'}
  end 
end
