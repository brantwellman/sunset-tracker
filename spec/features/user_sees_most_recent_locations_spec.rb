require "rails_helper"

RSpec.feature "user views most recent locations on dashboard", type: :feature do

  context "user sees most recent locations created" do
    it "sees 3 most recent locations" do
      user = create_user
      ApplicationController.any_instance.stubs(:current_user).returns(user)

      location1 = create(:location, address: "1526 Blake St", user_id: user.id)
      location2 = create(:location,
                          address: "331 Richland Ave",
                          city: "San Francisco",
                          state: "CA",
                          zipcode: "94110",
                          user_id: user.id)
      location3 = create(:location,
                          address: "6086 Groveoak Pl",
                          city: "Rancho Palos Verdes",
                          state: "CA",
                          zipcode: "90275",
                          user_id: user.id)
      location4 = create(:location,
                          address: "1285 Glenn St",
                          city: "Santa Rosa",
                          state: "CA",
                          zipcode: "95410",
                          user_id: user.id)

      visit dashboard_path
      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Denver")
      expect(page).to have_content("San Francisco")
      expect(page).to have_content("Rancho Palos Verdes")
      expect(page).to_not have_content("Santa Rosa")
    end
  end
end