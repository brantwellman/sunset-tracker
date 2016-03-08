class CreateForecasts < ActiveRecord::Migration
  def change
    create_table :forecasts do |t|
      t.float :cloud_cover
      t.float :precip_prob
      t.float :visibility
      t.float :precip_intensity
      t.float :ozone
      t.references :location, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
