class Location < ActiveRecord::Base
  validates :address, :city, :state, :zipcode, :date, presence: true
  geocoded_by :full_street_address
  after_validation :geocode
  belongs_to :user
  has_one :forecast

  def full_street_address
    unless address.nil? || city.nil? || state.nil? || zipcode.nil?
      address + ", " + city + ", " + state + ", " + zipcode
    end
  end

  def self.user_recent_locations(user)
    all.order(created_at: :desc).where(user_id: user.id).first(3)
  end

  def self.user_favorite_locations(user)
    where(favorite: 1, user_id: user.id)
  end

  def self.most_frequently_searched
    Location.group(:city).count.to_a[0..4].to_h
  end

end
