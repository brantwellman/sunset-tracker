class ForecastCleaner
  attr_accessor :forecasts

  def initialize(locations, date)
    @forecasts = []
    locations.each do |location|
      if location.forecast
        @forecasts << location.forecast.custom_hash
      else
        generate_forecast_data(location, date)
      end
    end
  end

  def timezones
    @forecasts.map do |forecast|
      forecast["timezone"]
    end
  end

  def sunrises
    @forecasts.each_with_index.map do |forecast, index|
      unix_rise = forecast["daily"]["data"].first["sunriseTime"]
      unix_to_display_time(unix_rise, index)
    end
  end

  def sunsets
    @forecasts.each_with_index.map do |forecast, index|
      unix_set = forecast["daily"]["data"].first["sunsetTime"]
      unix_to_display_time(unix_set, index)
    end
  end

  def unix_to_display_time(unix_time, index)
    Time.at(unix_time).in_time_zone(timezones[index]).strftime("%l:%M %p")
  end

  def sunrise_summary(forecast)
    unix_rise = forecast["daily"]["data"].first["sunriseTime"]
    closest_rise_hour = closest_hour(unix_rise)
    hour_forecast(closest_rise_hour, forecast)
  end

  def sunrises_weather
    @forecasts.map do |forecast|
      sunrise_summary(forecast)
    end
  end

  def sunset_summary(forecast)
    unix_set = forecast["daily"]["data"].first["sunsetTime"]
    closest_set_hour = closest_hour(unix_set)
    hour_forecast(closest_set_hour, forecast)
  end

  def sunsets_weather
    @forecasts.map do |forecast|
      sunset_summary(forecast)
    end
  end

  def closest_hour(unix_time)
    (unix_time.to_f/3600).round * 3600
  end

  def hour_forecast(top_hour, forecast)
    hourly_forecast = forecast["hourly"]["data"].find do |hour|
      hour["time"] == top_hour
    end
    if hourly_forecast.nil?
      "No Data"
    else
      hourly_forecast["summary"]
    end
  end

  def generate_forecast_data(location, date)
    forecast_hashes = ForecastService.new(location, date).forecast_info
    create_forecast(forecast_hashes, location)
    @forecasts << forecast_hashes
  end

  def create_forecast(forecast, location)
    Forecast.create(
                    cloud_cover: forecast["currently"]["cloudCover"],
                    visibility: forecast["currently"]["visibility"],
                    precip_prob: forecast["currently"]["precipProbability"],
                    precip_intensity: forecast["precipIntensity"],
                    ozone: forecast["currently"]["ozone"],
                    sunrise: forecast["daily"]["data"].first["sunriseTime"],
                    sunset: forecast["daily"]["data"].first["sunsetTime"],
                    sunrise_summary: sunrise_summary(forecast),
                    sunset_summary: sunset_summary(forecast),
                    location_id: location.id,
                    timezone: forecast["timezone"]
                    )
  end
end
