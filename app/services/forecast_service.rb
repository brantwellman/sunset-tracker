require 'open-uri'

class ForecastService
  attr_reader :location, :connection, :date

  def initialize(location)
    @location = location
    @date = location.date.to_i
    @connection = Faraday.new("https://api.forecast.io")
  end

  def forecast_info
    parse(connection.get("/forecast/#{ENV['DARKSKY_KEY']}/#{location.latitude},#{location.longitude},#{date}"))
  end

  private

    def parse(response)
      JSON.parse(response.body)
    end
end
