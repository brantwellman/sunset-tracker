require 'rails_helper'

RSpec.feature "unauthenticated user sees error" do
  it "visits the dashboard page and sees the 404 error" do
    visit dashboard_path

    expect(page).to have_content("The page you were looking for doesn't exist.")
  end
end
