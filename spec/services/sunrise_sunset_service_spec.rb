# require 'spec_helper'
# require 'rails_helper'
#
# describe "SunriseSunsetService" do
#
#   before do
#     @service = SunriseSunsetService.new(location)
#   end
#
#   context "sunrise" do
#     it "returns sunrise time for a location" do
#       VCR.use_cassette("sunrise_sunset_service#sunrise") do
#         sunrise = @service.sunrise
#
#         expect(sunrise).to eq("1:29:33 PM")
#
#       end
#     end
#   end
#
#   context "sunset" do
#     it "returns sunset time for a location" do
#       VCR.use_cassette("sunrise_sunset_service#sunset") do
#         sunset = @service.sunset
#
#         expect(sunset).to eq("12:54:10 AM")
#       end
#     end
#   end
#
# end
