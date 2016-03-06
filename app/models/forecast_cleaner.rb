class ForecastCleaner
  attr_reader :forecasts

  def initialize(locations, date=nil)
    @forecasts = []
    locations.each do |location|
      @forecasts << forecast ||= ForecastService.new(location, date).forecast_info
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
