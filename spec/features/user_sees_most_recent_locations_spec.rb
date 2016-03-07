require "rails_helper"

RSpec.feature "user views most recent locations on dashboard", type: :feature do

  context "user sees most recent locations created" do
    it "sees 3 most recent locations" do
        user = create_user
        ApplicationController.any_instance.stubs(:current_user).returns(user)

      VCR.use_cassette("forecast_service#user_most_recent1") do
        location1 = create(:location, address: "1526 Blake St", user_id: user.id)
      end
      VCR.use_cassette("forecast_service#user_most_recent2") do
        location2 = create(:location,
                            address: "331 Richland Ave",
                            city: "San Francisco",
                            state: "CA",
                            zipcode: "94110",
                            user_id: user.id)
      end
      VCR.use_cassette("forecast_service#user_most_recent3") do
        location3 = create(:location,
                            address: "6086 Groveoak Pl",
                            city: "Rancho Palos Verdes",
                            state: "CA",
                            zipcode: "90275",
                            user_id: user.id)
      end
      VCR.use_cassette("forecast_service#user_most_recent4") do
        location4 = create(:location,
                            address: "1285 Glenn St",
                            city: "Santa Rosa",
                            state: "CA",
                            zipcode: "95410",
                            user_id: user.id)
      end
      visit dashboard_path
      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Santa Rosa")
      expect(page).to have_content("San Francisco")
      expect(page).to have_content("Rancho Palos Verdes")
      expect(page).to_not have_content("Denver")
    end
  end
end
