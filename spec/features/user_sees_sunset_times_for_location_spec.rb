require "rails_helper"

RSpec.feature "user enters address to view sunset/sunrise times", type: :feature do

  context "user sees sunrise/sunset times after entering location and a date" do
    it "sees valid times" do
      user
      login(user)
      visit new_location_path

      fill_in "Address", with: "1510 Blake St"
      fill_in "City", with: "Denver"
      fill_in "State", with: "CO"
      fill_in "Zipcode", with: "80202"

      fill_in "Date", with: "2016-03-01"
      click_on "Submit"
      location = Location.first

      expect(current_path).to eq(location_path(location))
      expect(page).to have_content("Time of sunset:")
      expect(page).to have_content("5:05:55 PM")
    end
  end
end
