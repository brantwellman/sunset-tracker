class Location < ActiveRecord::Base
  geocoded_by :full_street_address
  after_validation :geocode
  belongs_to :user

  def full_street_address
    unless address.nil? || city.nil? || state.nil? || zipcode.nil?
      address + ", " + city + ", " + state + ", " + zipcode
    end
  end

end
