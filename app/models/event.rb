class Event < ActiveRecord::Base
  serialize :event_activities
  serialize :event_types

  scope :find_activity, ->(event_activity_id) { where(event_activities.include? event_activity_id)}
  scope :future, -> { where("dayof > ?", Date.today) }

  attr_accessible :contact, :desc, :location, :maker, :start, :end_date, :end_time, :cost, :cat, :dayof
  attr_accessible :address, :prizes, :host, :title, :latitude, :longitude, :website
  attr_accessible :approve, :isOnline, :event_activities, :event_types, :image
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>", :large => "600x400>" }, :default_url => "/images/:style/missing.png"

  belongs_to :user
  
  geocoded_by :address 
  validates :title, :maker, :cat, :presence => true
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  after_validation :geocode, :if => :address_changed?


  filterrific(
    # default_settings: { sorted_by: 'dayof_asc' },
    filter_names: [
      :search_query,
      :with_game_id,
      :with_event_type_id,
      :with_user_id
    ]
  )
  scope :search_query, lambda { |query|
    where("title like ?", "%#{query}%")
    # Filters students whose name or email matches the query
  }
  scope :with_game_id, lambda { |query|
    where("event_activities like ?", "%#{query}%") 
  }
  scope :with_event_type_id, lambda { |query|
    where("event_types like ?", "%#{query}%") 
  }
  scope :with_user_id, lambda { |query|
    where("user_id = ?", query) 
  }
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
    def eventTypeObjects
      if(self.event_types && self.event_types.length>0)
        return EventType.find_all_by_id(self.event_types)
      else
        return []
      end
    end


end
