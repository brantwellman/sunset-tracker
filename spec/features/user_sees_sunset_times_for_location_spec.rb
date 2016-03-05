require "rails_helper"

RSpec.feature "user enters address to view sunset/sunrise times", type: :feature, vcr: true do

  context "user sees sunrise/sunset times after entering location and a date" do
    it "sees valid times" do
      user = create_user
      ApplicationController.any_instance.stubs(:current_user).returns(user)

      visit new_location_path

      fill_in "Address", with: "1510 Blake St"
      fill_in "City", with: "Denver"
      fill_in "State", with: "CO"
      fill_in "Zipcode", with: "80202"

      fill_in "Date", with: "2016-03-01"
      click_on "Submit"
      location = Location.first

      expect(current_path).to eq(location_path(location))
      expect(page).to have_content("Sunset:")
      expect(page).to have_content("5:52 PM")
      expect(page).to have_content("Sunrise:")
      expect(page).to have_content("6:35 AM")
      expect(page).to have_content("Partly Cloudy")
    end
  end
end
