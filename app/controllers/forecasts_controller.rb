class ForecastsController < ApplicationController

  def data
    @forecasts = Location.where(city: "Denver").map {|loc| loc.forecast}
    @locations = Location.all
  end

end
