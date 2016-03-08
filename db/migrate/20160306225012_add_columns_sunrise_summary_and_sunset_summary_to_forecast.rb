class AddColumnsSunriseSummaryAndSunsetSummaryToForecast < ActiveRecord::Migration
  def change
    add_column :forecasts, :sunrise_summary, :string
    add_column :forecasts, :sunset_summary, :string
  end
end
