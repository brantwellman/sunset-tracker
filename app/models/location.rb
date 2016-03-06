class Location < ActiveRecord::Base
  validates :address, :city, :state, :zipcode, :date, presence: true
  geocoded_by :full_street_address
  after_validation :geocode
  belongs_to :user

  def full_street_address
    unless address.nil? || city.nil? || state.nil? || zipcode.nil?
      address + ", " + city + ", " + state + ", " + zipcode
    end
  end

  def self.user_locations(user)
    all.order(id: :desc).where(user_id: user.id)
  end

end
