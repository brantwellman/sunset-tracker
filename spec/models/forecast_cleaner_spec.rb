require 'rails_helper'
require 'spec_helper'

describe "ForecastCleaner" do

  before do
    @cleaner = ForecastCleaner.new(location)
  end

  it "returns the timezone" do
    zone = @cleaner.timezone

    expect(zone).to eq("America/Denver")
  end

end
