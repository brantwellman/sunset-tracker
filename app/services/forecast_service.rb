require 'open-uri'

class ForecastService
  attr_reader :location, :connection

  def initialize(location)
    @location = location
    @connection = Faraday.new("https://api.forecast.io")
  end

  def forecast_info
    date = location.date.to_i
    parse(connection.get("/forecast/#{ENV['DARKSKY_KEY']}/#{location.latitude},#{location.longitude},#{date}"))
  end

  def sunrise
    unix_rise = forecast_info["daily"]["data"].first["sunriseTime"]
    Time.at(unix_rise).in_time_zone(timezone).strftime("%l:%M %p")
  end

  def sunset
    unix_set = forecast_info["daily"]["data"].first["sunsetTime"]
    Time.at(unix_set).in_time_zone(timezone).strftime("%l:%M %p")
  end

  def timezone
    forecast_info["timezone"]
  end

  def sunrise_weather
    unix_rise = forecast_info["daily"]["data"].first["sunriseTime"]
    closest_rise_hour = (unix_rise.to_f/3600).round * 3600
    hour_forecast = forecast_info["hourly"]["data"].find do |hour|
      hour["time"] == closest_rise_hour
    end
    hour_forecast["summary"]
  end

  def sunset_weather
    unix_set = forecast_info["daily"]["data"].first["sunsetTime"]
    closest_set_hour = (unix_set.to_f/3600).round * 3600
    hour_forecast = forecast_info["hourly"]["data"].find do |hour|
      hour["time"] == closest_set_hour
    end
    hour_forecast["summary"]
  end

# Time.at(1456822800).in_time_zone("America/Denver")
# Time.at(1456815600).strftime("%I:%M %p")

  private

    def parse(response)
      JSON.parse(response.body)
    end
end
