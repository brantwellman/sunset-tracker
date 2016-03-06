require "rails_helper"

RSpec.feature "user logs out", type: :feature do

  context "user sees root page after logging out" do
    it "can log out" do
      visit root_path
      click_on "Login with Twitter"

      visit new_location_path
      click_on "Logout"

      expect(current_path).to eq(root_path)
      expect(page).to have_link("Login with Twitter")
    end
  end
end
