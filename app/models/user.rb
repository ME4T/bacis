class User < ActiveRecord::Base
  
  has_many :friends, :dependent => :destroy
  has_many :transactions
  has_many :events
  has_many :authentications, :dependent => :destroy
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me
  attr_accessible :provider, :uid, :name, :address,:latitude,:longitude, :admin, :login
  
  # attr_accessible :title, :body
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
  

validates :email, :uniqueness => true

validates :username,
  :presence => true,
  :uniqueness => {
    :case_sensitive => false
  }

  attr_accessor :login
  
def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:provider => access_token.provider, :uid => access_token.uid ).first
    if user
      return user
    else
      registered_user = User.where(:email => access_token.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create(name: data["name"],
          provider:access_token.provider,
          email: data["email"],
          uid: access_token.uid ,
          password: Devise.friendly_token[0,20],
        )
      end
   end
end

  def apply_omniauth(omni)
    authentications.build(:provider => omni['provider'], 
                          :uid => omni['uid'], 
                          :token => omni['credentials'].token, 
                          :token_secret => omni['credentials'].secret)
                          
  end
  
  def self.from_omniauth(auth)
    

    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid 
      user.username = auth.info.name
      user.password= Devise.friendly_token[0,20]
      someemail = ""
      if(auth.info.nickname)
        someemail = "#{auth.info.nickname}@NOTREALLY#{auth.provider}.com".sub! " ", ""
      else
        someemail = "#{auth.info.name}@NOTREALLY#{auth.provider}.com".sub! " ", ""
      end
      
      user.email = someemail

      # if(auth.info.email)
      #   user.email= auth.info.email
      # else
      # end
      user.name=auth.info.name
      user.save!
    end
  end
    
  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end
  
  def password_required?
    (authentications.empty? || !password.blank?) && super #&& provider.blank?
  end
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
    end
  end
  
  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end
  
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(  provider:auth.provider,
                           uid:auth.uid,
                           email:auth.info.email,
                           name:auto.info.name,
                           password:Devise.friendly_token[0,20]
                           )
    end
    user
  end
  
def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      else
        where(conditions).first
      end
    end

  def total_borrows
    self.transactions.where(:t_type => 1, :status => 0).sum(:amount)
  end
  
  def total_lends
    self.transactions.where(:t_type => 2, :status => 0).sum(:amount)
  end
  
    def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end



  private

    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end
  
end
