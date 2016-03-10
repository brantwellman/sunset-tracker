require "rails_helper"

RSpec.feature "user can favorite a location", type: :feature do

  context "user sees favorites and recents" do
    it "favorites a location and it appears in the favorite section" do
      user = create_user
      ApplicationController.any_instance.stubs(:current_user).returns(user)

      location1 = create(:location, address: "1526 Blake St", user_id: user.id)

      visit dashboard_path

      expect(current_path).to eq(dashboard_path)

      within("#recents-table") do
        expect(page).to have_content("Denver")
      end

      expect(page).to have_link("Add to favorites")

      click_on "Add to favorites"

      expect(current_path).to eq(dashboard_path)

      within("#recents-table") do
        expect(page).to_not have_content("Denver")
      end

      within("#favorites-table") do
        expect(page).to have_content("Denver")
      end
    end
  end
end
# 
