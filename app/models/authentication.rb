class Authentication < ActiveRecord::Base
  attr_accessible :provider, :uid, :token, :token_secret, :user_id
  belongs_to :user
  
  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      auth.provider = auth.provider
      auth.uid = auth.uid
      auth.token = auth.token
      auth.token_secret = auth.token_secret
    end
  end
end
