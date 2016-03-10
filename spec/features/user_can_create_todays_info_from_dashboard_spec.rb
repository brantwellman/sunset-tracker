require "rails_helper"

RSpec.feature "user can click link to see todays data from favorite or recent location" do
  it "sees today's sunrise and sunset time" do
    user = create_user
    VCR.use_cassette("forecast_service#todays_info") do
      location = Location.create(address: "1510 Blake St",
                                 city: "Denver",
                                 state: "CO",
                                 zipcode: "80202",
                                 user_id: user.id,
                                 date: "2016-03-01 17:28:55"
                                )

    end
    ApplicationController.any_instance.stubs(:current_user).returns(user)
    visit dashboard_path
    click_link "Today's Info"
    expect(page).to have_content("6:21 AM")
    expect(page).to have_content("Clear")
    expect(page).to have_content("6:02 PM")
    expect(page).to have_content("Mostly Cloudy")

  end
end
