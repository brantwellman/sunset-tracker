class Forecast < ActiveRecord::Base
  belongs_to :location

  def custom_hash
    { "timezone" => self.timezone,
      "hourly" => {
        "data" => [
          {
            "time" => self.sunrise.to_i,
            "summary" => self.sunrise_summary
          },
          {
            "time" => self.sunset.to_i,
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
end
