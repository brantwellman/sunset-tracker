# require 'open-uri'
#
# class SunriseSunsetService
#   attr_reader :connection, :location
#
#   def initialize(location)
#     @connection = Faraday.new("http://api.sunrise-sunset.org")
#     @location = location
#   end
#
#   def sunrise_sunset
#     parse(connection.get("/json?lat=#{location.latitude}&lng=#{location.longitude}&date=#{location.date}"))
#   end
#
#   def sunrise
#     sunrise_sunset["results"]["sunrise"]
#   end
#
#   def sunset
#     sunrise_sunset["results"]["sunset"]
#   end
#
#   private
#
#     def parse(response)
#       JSON.parse(response.body)
#     end
#
# end
