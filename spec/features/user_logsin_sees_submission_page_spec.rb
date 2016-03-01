require "rails_helper"

RSpec.feature "user logs in", type: :feature do

  context "user sees data submission page after logging in" do
    it "can log in" do
      visit "/"

      click_link "Login with Twitter"

      expect(current_path).to eq(new_location_path)
      expect(page).to have_content("Where do you want to see the sunset?")
    end
  end
end
