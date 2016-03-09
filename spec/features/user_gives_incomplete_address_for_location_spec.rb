require "rails_helper"

RSpec.feature "user provides incomplete address for location" do
  it "gives a incomplete address and sees a flash message" do
    VCR.use_cassette("forecast_service#incomplete_address") do
      user = create_user
      ApplicationController.any_instance.stubs(:current_user).returns(user)

      visit new_location_path

      fill_in "Address", with: "2739 Lafayette St"
      fill_in "City", with: "Denver"
      fill_in "State", with: "CO"
      fill_in "Date", with: "2016-03-01"
      click_on "Submit"

      expect(page).to have_content("You must fill out each field")
    end
  end
end
