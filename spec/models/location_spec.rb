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

  it "returns the 5 most frequently searched locations" do
    locations = create_list(:location, 4)
    location1 = create(:location, city: "San Francisco")
    location2 = create(:location, city: "San Francisco")
    location3 = create(:location, city: "San Francisco")
    location4 = create(:location, city: "Boulder")
    location5 = create(:location, city: "Boulder")
    location6 = create(:location, city: "Boulder")
    location7 = create(:location, city: "Seattle")
    location8 = create(:location, city: "Seattle")
    location9 = create(:location, city: "Portland")
    location10 = create(:location, city: "Portland")
    location11 = create(:location, city: "Santa Rosa")
    location12 = create(:location, city: "San Pedro")

    actual = Location.most_frequently_searched
    expected = {
                "Denver" => 4,
                "San Francisco" => 3,
                "Boulder" => 3,
                "Seattle" => 2,
                "Portland" => 2
              }
    expect(actual).to eq(expected)
  end
end
