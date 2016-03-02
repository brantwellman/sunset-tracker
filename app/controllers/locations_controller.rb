require 'open-uri'

class LocationsController < ApplicationController

  def new
    @location = Location.new
  end

  def show
    @location = Location.find(params[:id])
    forecast_service = ForecastService.new(@location)
    @forecast_info = forecast_service.forecast_info
    @sunrise = forecast_service.sunrise
    @sunset = forecast_service.sunset
    @sunrise_weather = forecast_service.sunrise_weather
    @sunset_weather = forecast_service.sunset_weather
    # sun_service = SunriseSunsetService.new(@location)
    # @sunrise = sun_service.sunrise
  end

  def create
    @location = Location.create(location_params)
    if @location.save
      redirect_to location_path(@location)
    else
      flash.now[:errors] = @item.errors.full_messages.join(", ")
      redirect_to new_location_path
    end
  end

  private

    def location_params
      params.require(:location).permit(:address, :city, :state, :zipcode, :date)
    end
end
