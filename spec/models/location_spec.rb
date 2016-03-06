require 'rails_helper'

RSpec.describe Location, type: :model do
  it { should validate_presence_of(:date) }
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:state) }
  it { should validate_presence_of(:zipcode) }

  it "returns full address in string" do
    location = create(:location)
    expected = "1510 Blake St, Denver, CO, 80202"

    expect(location.full_street_address).to eq(expected)
  end
end
