require "rails_helper"

RSpec.feature "users sees most frequently created locations on data page" do
  it "sees the most frequently created locations" do
    VCR.use_cassette("forecast_service#most_frequently_searched") do
      user = create_user
      ApplicationController.any_instance.stubs(:current_user).returns(user)
      create_list(:location, 3)
      create(:location, address: "331 Richland Ave",
                        city: "San Francisco",
                        state: "CA",
                        zipcode: "94110",
                        date: "2016-03-01 17:28:55"
            )
      create(:location, address: "1285 Glenn St",
                        city: "Santa Rosa",
                        state: "CA",
                        zipcode: "95409",
                        date: "2016-03-01"
            )

      visit data_path

      expect(page).to have_content("Sunset Tracker's Most Frequently")
    end
  end
end
