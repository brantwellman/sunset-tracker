require 'open-uri'

class ForecastService
  attr_reader :location, :connection, :date

  def initialize(location, date=nil)
    @location = location
    if date.nil?
      @date = location.date.to_i
    else
      @date = date
    end
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
