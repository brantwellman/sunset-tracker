class Forecast < ActiveRecord::Base
  belongs_to :location

  def custom_hash
    { "timezone" => self.timezone,
      "currently" => {
        "cloudCover" => self.cloud_cover,
        "visibility" => self.visibility,
        "precipProbability" => self.precip_prob,
        "precipIntensity" => self.precip_intensity,
        "currently" => self.ozone
      },
      "hourly" => {
        "data" => [
          {
            "time" => top_hour(self.sunrise.to_i),
            "summary" => self.sunrise_summary
          },
          {
            "time" => top_hour(self.sunset.to_i),
            "summary" => self.sunset_summary
          }
          ]
      },
      "daily" => {
        "data" => [{
          "sunriseTime" => self.sunrise.to_i,
          "sunsetTime" => self.sunset.to_i
          }]
        }
    }
  end

  def top_hour(time)
    (time.to_f/3600).round * 3600
  end
end
