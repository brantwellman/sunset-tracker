require 'rails_helper'
require 'spec_helper'

describe "ForecastCleaner" do

  before do
    @cleaner = ForecastCleaner.new(location)
  end

  it "returns the timezone" do
    zone = @cleaner.timezone

    expect(zone).to eq("America/Denver")
  end

  it "returns the sunrise time in the proper format" do
    zone = @cleaner.timezone
    time = @cleaner.sunrise

    expect(time).to eq(" 6:33 AM")
  end

  it "returns the sunset time in the proper format" do
    zone = @cleaner.timezone
    time = @cleaner.sunset

    expect(time).to eq(" 5:53 PM")
  end

  it "retuns the weather for the matching sunset time" do
    weather = @cleaner.sunset_weather

    expect(weather).to eq("Partly Cloudy")
  end

  it "retuns the weather for the matching sunrise time" do
    VCR.use_cassette("forecast_service#forecast_info") do

      weather = @cleaner.sunrise_weather

      expect(weather).to eq("Clear")
    end
  end

  it "returns rounds the unix time to the nearest hour" do
    top_of_the_hour = @cleaner.closest_hour(1456833900)
    expect(top_of_the_hour).to eq(1456833600)

    top_of_the_hour = @cleaner.closest_hour(1456835600)
    expect(top_of_the_hour).to eq(1456837200)
  end

  it "returns the proper hourly forecast given the unix time" do
    VCR.use_cassette("forecast_service#forecast_info") do

      forecast = @cleaner.hour_forecast(1456837200)

      expect(forecast).to eq("Clear")
    end
  end
end
