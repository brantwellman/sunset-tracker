class ForecastCleaner
  attr_reader :forecast

  def initialize(location)
    @forecast ||= ForecastService.new(location).forecast_info
  end

  def timezone
    forecast["timezone"]
  end

  def sunrise
    unix_rise = forecast["daily"]["data"].first["sunriseTime"]
    Time.at(unix_rise).in_time_zone(timezone).strftime("%l:%M %p")
  end

  def sunset
    unix_set = forecast["daily"]["data"].first["sunsetTime"]
    Time.at(unix_set).in_time_zone(timezone).strftime("%l:%M %p")
  end

  def sunrise_weather
    unix_rise = forecast["daily"]["data"].first["sunriseTime"]
    closest_rise_hour = closest_hour(unix_rise)
    hour_forecast(closest_rise_hour)
  end

  def sunset_weather
    unix_set = forecast["daily"]["data"].first["sunsetTime"]
    closest_set_hour = closest_hour(unix_set)
    hour_forecast(closest_set_hour)
  end

  def closest_hour(unix_time)
    (unix_time.to_f/3600).round * 3600
  end

  def hour_forecast(top_hour)
    hour_forecast = forecast["hourly"]["data"].find do |hour|
      hour["time"] == top_hour
    end
    hour_forecast["summary"]
  end
end
