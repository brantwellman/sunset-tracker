require 'simplecov'
SimpleCov.start 'rails'

def user
  User.create(
              nickname: "bdubb",
              name: "Brant Wellman",
              location: "Denver, CO",
              secret: ENV['BW_SECRET'],
              token: ENV['BW_TOKEN'],
              uid: "12345",
              provider: "twitter"
              )
end

def login(user)
  visit root_path
  click_on "Login with Twitter"
end

def location
  Location.create(
                  address: "1510 Blake St",
                  city: "Denver",
                  state: "CO",
                  zipcode: "80202",
                  date: "2016-03-02 00:00:00"
  )
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
