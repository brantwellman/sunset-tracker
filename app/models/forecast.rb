class Forecast < ActiveRecord::Base
  belongs_to :location

  def custom_hash
    { "timezone": self.timezone, 
      "daily": {
        "data": {
          "sunriseTime": self.sunrise,
          "sunsetTime": self.sunset
        }
      }
    }
  end
end
