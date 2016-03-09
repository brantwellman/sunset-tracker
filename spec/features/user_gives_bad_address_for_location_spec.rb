require "rails_helper"

RSpec.feature "user provides bad address for location" do
  it "gives a bad address and sees a flash message" do
    VCR.use_cassette("forecast_service#bad_address") do
      user = create_user
      ApplicationController.any_instance.stubs(:current_user).returns(user)

      visit new_location_path

      fill_in "Address", with: "2739 Lafayette St"
      fill_in "City", with: "Denver"
      fill_in "State", with: "CO"
      fill_in "Zipcode", with: "99999999999"
      fill_in "Date", with: "2016-03-01"
      click_on "Submit"

      expect(page).to have_content("Sorry, that was an invalid address")
    end
  end
end
