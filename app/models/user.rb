class User < ActiveRecord::Base
  attr_accessible :name, :oauth_expires_at, :oauth_token, :provider, :uid

  # def self.create_with_omniauth(auth)
    # create! do |user|
      # user.provider = auth["provider"]
      # user.uid = auth["uid"]
      # user.name = auth["info"]["name"]
    # end
  # end
  
  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token 
      if user.provider == 'facebook'
        user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      elsif user.provider == 'twitter'
        user.oauth_secret = auth.credentials.secret  
      end
      user.save!
      #user.image = auth.info.image 
    end
  end
  
  #-----------------Facebook Stuff---------------------------

  def facebook
    @facebook ||= Koala::Facebook::API.new(oauth_token)
    block_given? ? yield(@facebook) : @facebook
  rescue Koala::Facebook::APIError => e
    logger.info e.to_s
    nil
  end

  def friends_count
    facebook { |fb| fb.get_connection("me","friends").size }
  end
  
  #-----------------Twitter Stuff---------------------------
  def twitter
    if provider == "twitter"
      @twitter ||= Twitter::Client.new(oauth_token: oauth_token, oauth_token_secret: oauth_secret)
    end
  end
  
end