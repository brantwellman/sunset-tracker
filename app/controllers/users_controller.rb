class UsersController < ApplicationController
  before_action :unauthenticated_user_error, only: [:forecast_data, :show]

  def show
    @favorites = Location.user_favorite_locations(current_user)
    @favorite_cleaned = ForecastCleaner.new(@favorites, Time.now.to_i)

    @recents = Location.user_recent_locations(current_user)
    @recent_cleaned = ForecastCleaner.new(@recents, Time.now.to_i)
  end
end
