require 'simplecov'
SimpleCov.start 'rails'

def create_user
  User.create(
              nickname: "bdubb",
              name: "Brant Wellman",
              location: "Denver, CO",
              secret: ENV['BW_SECRET'],
              token: ENV['BW_TOKEN'],
              uid: "12345",
              provider: "twitter",
              )
end

def login(create_user)
  visit root_path
  click_on "Login with Twitter"
end

def location
  location = Location.create(
                  address: "1510 Blake St",
                  city: "Denver",
                  state: "CO",
                  zipcode: "80202",
                  date: "2016-03-02 00:00:00",
                  latitude: 39.749635,
                  longitude: -105.000106
                  )
  forecast = Forecast.create(
                      location_id: location.id,
                      cloud_cover: 0.23,
                      precip_prob: 0.23,
                      visibility: 4.5,
                      precip_intensity: 2.3,
                      ozone: 2.3,
                      summary: "Clear",
                      sunrise: Time.zone.at(1457011843),
                      sunset: Time.zone.at(1457052944),
                      timezone: "America/Denver",
                      sunrise_summary: "Clear",
                      sunset_summary: "Cloudy"
                      )
  location
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :mocha
  # config.mock_with :rspec do |mocks|
  #   mocks.verify_partial_doubles = true
  # end
end
