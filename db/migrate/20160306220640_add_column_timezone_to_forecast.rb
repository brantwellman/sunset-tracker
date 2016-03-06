class AddColumnTimezoneToForecast < ActiveRecord::Migration
  def change
    add_column :forecasts, :timezone, :string
  end
end
