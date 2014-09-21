class Event < ActiveRecord::Base
  serialize :event_activities

  attr_accessible :contact, :desc, :location, :maker, :start, :end_date, :end_time, :cost, :cat, :dayof
  attr_accessible :address, :prizes, :host, :title, :latitude, :longitude, :website
  attr_accessible :approve, :isOnline, :event_activities

  belongs_to :user
  
  geocoded_by :address 
  validates :title,   :maker, :cat, :presence => true
  after_validation :geocode, :if => :address_changed?
    def gmaps4rails_address
      self.address #describe how to retrieve the address from your model
    end
    def geocode?
      (!address.blank? && (latitude.blank? || longitude.blank?)) || address_changed?
    end

    def eventActivityObjects
      if(self.event_activities && self.event_activities.length>0)
        return EventActivity.find_all_by_id(self.event_activities)
      else
        return []
      end
    end
end
