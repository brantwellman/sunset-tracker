require 'open-uri'

class LocationsController < ApplicationController
  before_action :unauthenticated_user_error, only: [:new, :show]

  def new
    if current_user
      @location = Location.new
    else
      unauthenticated_user_error
    end
  end

  def show
    @location = Location.find(params[:id])
    @cleaner = ForecastCleaner.new([@location], @location.date.to_i)
  end

  def create
    @location = Location.create(location_params)
    if @location.save
      current_user.locations << @location
      redirect_to location_path(@location)
    else
      flash[:error] = "You must fill out each field"
      redirect_to new_location_path
    end
  end

  def update
    @location = Location.find(params[:id])
    if @location.favorite == 0
      @location.update_attribute(:favorite, 1)
    else
      @location.update_attribute(:favorite, 0)
    end
    redirect_to dashboard_path
  end

  private

    def location_params
      params.require(:location).permit(:address, :city, :state, :zipcode, :date)
    end
end
