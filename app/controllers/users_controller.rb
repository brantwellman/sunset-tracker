class UsersController < ApplicationController
  def show
    @locations = current_user.locations[0..2]
    @cleaner = ForecastCleaner.new(@locations)
  end
end
