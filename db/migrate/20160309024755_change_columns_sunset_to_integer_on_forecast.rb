class ChangeColumnsSunsetToIntegerOnForecast < ActiveRecord::Migration
  def change
    remove_column :forecasts, :sunset, :datetime
    add_column :forecasts, :sunset, :integer

  end
end
