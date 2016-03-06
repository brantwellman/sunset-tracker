require 'rails_helper'
require 'spec_helper'

describe "ForecastCleaner" do

  before do
    @cleaner = ForecastCleaner.new([location])
  end

  context "timezone" do
    VCR.use_cassette("forecast_cleaner#timezones") do
      it "returns the timezone" do
        zone = @cleaner.timezones[0]

        expect(zone).to eq("America/Denver")
      end
    end
  end

  context "sunrise time" do
    VCR.use_cassette("forecast_cleaner#sunrise_time") do
      it "returns the sunrise time in the proper format" do
        zone = @cleaner.timezones[0]
        time = @cleaner.sunrises[0]

        expect(time).to eq(" 6:33 AM")
      end
    end
  end

  context "sunset time" do
    VCR.use_cassette("forecast_cleaner#sunset_time") do
      it "returns the sunset time in the proper format" do
        zone = @cleaner.timezones[0]
        time = @cleaner.sunsets[0]

        expect(time).to eq(" 5:53 PM")
      end
    end
  end

  context "weather for sunset time" do
    VCR.use_cassette("forecast_cleaner#weather_sunset_time") do
      it "retuns the weather for the matching sunset time" do
        weather = @cleaner.sunsets_weather[0]

        expect(weather).to eq("Partly Cloudy")
      end
    end
  end

  context "weather for sunrise time" do
    VCR.use_cassette("forecast_service#weather_sunset_time") do
      it "retuns the weather for the matching sunrise time" do

        weather = @cleaner.sunrises_weather[0]

        expect(weather).to eq("Clear")
      end
    end
  end

  context "unix time" do
    VCR.use_cassette("forecast_service#unix_time_hour") do
      it "returns rounds the unix time to the nearest hour" do
        top_of_the_hour = @cleaner.closest_hour(1456833900)
        expect(top_of_the_hour).to eq(1456833600)

        top_of_the_hour = @cleaner.closest_hour(1456835600)
        expect(top_of_the_hour).to eq(1456837200)
      end
    end
  end

  it "returns the proper hourly forecast given the unix time" do
    VCR.use_cassette("forecast_service#forecast_info") do
      forecast = @cleaner.forecasts[0]

      weather = @cleaner.hour_forecast(1456837200, forecast)

      expect(weather).to eq("Clear")
    end
  end
end
