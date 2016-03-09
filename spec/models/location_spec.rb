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

  it "returns the users favorite locations" do
    user1 = User.create(name: "George", id: 1)
    user2 = User.create(name: "Daniel", id: 2)
    location1 = create(:location, city: "San Francisco", favorite: 1, user_id: 1)
    location2 = create(:location, city: "San Jose", favorite: 1, user_id: 1)
    location3 = create(:location, city: "Portland", favorite: 0, user_id: 1)
    location4 = create(:location, city: "Denver", favorite: 1, user_id: 2)
    location5 = create(:location, city: "Seattle", favorite: 1, user_id: 2)

    actual = Location.user_favorite_locations(user1)

    expect(actual.count).to eq(2)
  end

  it "returns the users 3 most recent locations" do
    user = User.create(name: "George", id: 1)
    user2 = User.create(name: "Daniel", id: 2)
    location1 = create(:location, city: "San Francisco", favorite: 1, user_id: 1)
    location2 = create(:location, city: "San Jose", favorite: 1, user_id: 1)
    location3 = create(:location, city: "Portland", favorite: 0, user_id: 1)
    location3 = create(:location, city: "Boulder", favorite: 0, user_id: 1)
    location4 = create(:location, city: "Denver", favorite: 1, user_id: 2)
    location5 = create(:location, city: "Seattle", favorite: 1, user_id: 2)

    user_recents = Location.user_recent_locations(user)

    expect(user_recents.count).to eq(3)
    expect(user_recents[0].city).to eq("Boulder")
    expect(user_recents[1].city).to eq("Portland")
    expect(user_recents[2].city).to eq("San Jose")
  end
end
