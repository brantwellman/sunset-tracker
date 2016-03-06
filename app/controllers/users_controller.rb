class UsersController < ApplicationController
  def show
    @locations = Location.user_locations(current_user)
    @cleaner = ForecastCleaner.new(@locations, Time.now.to_i)
  end
end
