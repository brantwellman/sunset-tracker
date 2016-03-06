require "rails_helper"

RSpec.feature "user can unfavorite a location", type: :feature do

  context "user sees favorites and recents" do
    it "un-favorites a location and it appears in the recent section" do
      user = create_user
      ApplicationController.any_instance.stubs(:current_user).returns(user)

      location1 = create(:location, address: "1526 Blake St", user_id: user.id, favorite: 1)

      visit dashboard_path

      expect(current_path).to eq(dashboard_path)

      within("#favorites-table") do
        expect(page).to have_content("Denver")
      end

      expect(page).to have_link("Remove from favorites")

      click_on "Remove from favorites"

      expect(current_path).to eq(dashboard_path)

      within("#favorites-table") do
        expect(page).to_not have_content("Denver")
      end

      within("#recents-table") do
        expect(page).to have_content("Denver")
      end
    end
  end
end
