require 'rails_helper'

RSpec.describe Location, type: :model do
  it "returns full address in string" do
    location = create(:location)
    expected = "1510 Blake St, Denver, CO, 80202"

    expect(location.full_street_address).to eq(expected)
  end
end
