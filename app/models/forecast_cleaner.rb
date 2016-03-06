class ForecastCleaner
  attr_reader :forecasts

  def initialize(locations, date=nil)
    @forecasts = []
    locations.each do |location|

      if location.find_by(date: date, latitude: location.latitude, longitude: location.longitude)
        @forecasts << location.forecast.custom_hash
        #option1  make and call here .custom_to_hash in forecast model
      else
        @forecasts << forecast ||= ForecastService.new(location, date).forecast_info
        binding.pry
        @forecasts.each do |forecast_hash|
          create_forecast(forecast_hash, location)
        end
      end
        #option 1 needs also to create forecast model associated to this location model for this info.
        #option 1.1 you can make that model here.
        #option 1.1 continued:  create_model(forecast hash) where create model is a method here
        #option 1.2 you make the model in forecast service.  FUCK THIS option
      # end
      @forecasts << forecast ||= ForecastService.new(location, date).forecast_info
    end
  end

  def create_forecast(forecast, location)
    Forecast.create(
                    summary: forecast["summary"],
                    cloud_cover: forecast["cloudCover"],
                    visibility: forecast["visibility"],
                    precip_prob: forecast["precipProbability"],
                    precip_intensity: forecast["precipIntensity"],
                    ozone: forecast["ozone"],
                    sunrise: sunrise_time(forecast),
                    sunset: sunset_time(forecast),
                    location_id: location.id,
                    timezone: forecast["timezone"]
                    )
  end

  def timezones
    @forecasts.map do |forecast|
      forecast["timezone"]
    end
  end

  def sunrise_time(forecast)
    unix_rise = forecast["daily"]["data"].first["sunriseTime"]
    Time.at(unix_rise).in_time_zone(timezones[index]).strftime("%l:%M %p")
  end

  def sunset_time(forecast)
    unix_set = forecast["daily"]["data"].first["sunsetTime"]
    Time.at(unix_set).in_time_zone(timezones[index]).strftime("%l:%M %p")
  end

  def sunrises
    @forecasts.each_with_index.map do |forecast, index|
      unix_rise = forecast["daily"]["data"].first["sunriseTime"]
      Time.at(unix_rise).in_time_zone(timezones[index]).strftime("%l:%M %p")
    end
  end

  def sunsets
    @forecasts.each_with_index.map do |forecast, index|
      unix_set = forecast["daily"]["data"].first["sunsetTime"]
      Time.at(unix_set).in_time_zone(timezones[index]).strftime("%l:%M %p")
    end
  end

  def sunrises_weather
    @forecasts.map do |forecast|
      unix_rise = forecast["daily"]["data"].first["sunriseTime"]
      closest_rise_hour = closest_hour(unix_rise)
      hour_forecast(closest_rise_hour, forecast)
    end
  end

  def sunsets_weather
    @forecasts.map do |forecast|
      unix_set = forecast["daily"]["data"].first["sunsetTime"]
      closest_set_hour = closest_hour(unix_set)
      hour_forecast(closest_set_hour, forecast)
    end
  end

  def closest_hour(unix_time)
    (unix_time.to_f/3600).round * 3600
  end

  def hour_forecast(top_hour, forecast)
    hour_forecast = forecast["hourly"]["data"].find do |hour|
      hour["time"] == top_hour
    end
    if hour_forecast.nil?
      "No Data"
    else
      hour_forecast["summary"]
    end
  end
end
