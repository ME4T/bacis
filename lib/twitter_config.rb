#lib/twitter_config.rb
module TwitterConfig
  def self.config
    @@config ||= {}
  end

  def self.config=(hash)
    @@config = hash
  end
end