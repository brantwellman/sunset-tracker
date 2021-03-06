require 'spec_helper'
require 'rails_helper'

describe "ForecastService" do

  context "forecast" do
    it "returns full forecast object" do
      VCR.use_cassette("forecast_service#forecast_info") do
        @service = ForecastService.new(location, location.date.to_i)
        forecast_info = @service.forecast_info
        timezone = forecast_info["timezone"]
        latitude = forecast_info["latitude"]
        sunset = forecast_info["daily"]["data"].first["sunsetTime"]

        expect(timezone).to eq("America/Denver")
        expect(latitude).to eq(39.749568939208984)
        expect(sunset).to eq(1456880016)
      end
    end
  end

end
