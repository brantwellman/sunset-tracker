class Location < ActiveRecord::Base
  validates :address, :city, :state, :zipcode, :date, :latitude, :longitude, presence: true
  geocoded_by :full_street_address
  after_validation :geocode
  belongs_to :user

  def full_street_address
    unless address.nil? || city.nil? || state.nil? || zipcode.nil?
      address + ", " + city + ", " + state + ", " + zipcode
    end
  end

  def self.user_recent_locations(user)
    all.order(id: :desc).where(user_id: user.id).first(3)
  end

  def self.user_favorite_locations(user)
    where(favorite: 1)
  end

end
