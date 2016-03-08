class AddColumnsToForecast < ActiveRecord::Migration
  def change
    add_column :forecasts, :summary, :string
    add_column :forecasts, :sunrise, :datetime
    add_column :forecasts, :sunset, :datetime 
  end
end
