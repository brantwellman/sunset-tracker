class ChangeColumnsSunriseAndSunsetOnForecast < ActiveRecord::Migration
  def change
    remove_column :forecasts, :sunrise, :datetime
    add_column :forecasts, :sunrise, :integer
  end
end
