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

  private

    def parse(response)
      JSON.parse(response.body)
    end
end
