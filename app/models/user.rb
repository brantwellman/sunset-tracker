class User < ActiveRecord::Base
  has_many :locations

  def self.find_or_create_by_auth_hash(auth)
    user = User.find_or_create_by(provider: auth["provider"], uid: auth["uid"])

    user.nickname = auth["info"]["nickname"]
    user.name = auth["info"]["name"]
    user.location = auth["info"]["location"]
    user.secret = auth["credentials"]["secret"]
    user.uid = auth["uid"]
    user.token = auth["credentials"]["token"]
    user.provider = auth["provider"]
    user.save
    user
  end

end
