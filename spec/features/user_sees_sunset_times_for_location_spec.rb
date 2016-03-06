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

  context "user sees flash for not entering all necessary location data" do
    it "sees flash message" do
      user = create_user
      ApplicationController.any_instance.stubs(:current_user).returns(user)

      visit new_location_path

      fill_in "Address", with: "1510 Blake St"
      fill_in "City", with: "Denver"
      fill_in "State", with: "CO"
      fill_in "Zipcode", with: "80202"

      click_on "Submit"

      expect(page).to have_content("You must fill out each field")
      expect(current_path).to eq(new_location_path)
    end
  end

  context "user sees flash for no data for location/date" do
    it "sees flash message" do
      user = create_user
      ApplicationController.any_instance.stubs(:current_user).returns(user)

      visit new_location_path

      fill_in "Address", with: "4200 Franklin St"
      fill_in "City", with: "Anchorage"
      fill_in "State", with: "FR"
      fill_in "Zipcode", with: "99501"

      click_on "Submit"

      expect(page).to have_content("Sorry there is no data for that location/date")
      expect(current_path).to eq(new_location_path)
    end
  end
end
