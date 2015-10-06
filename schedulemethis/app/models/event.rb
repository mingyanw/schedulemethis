class Event < ActiveRecord::Base
  # Relationships
  belongs_to :schedule
  has_many :event_instances
  has_one :event_recurrence

  # Required Fields
  validates_presence_of :short_description, :estimated_time_required, :priority

  # Scopes
  scope :closest_end_date, -> { order(end_date: :asc) }
  scope :recently_created, -> { order(created_at: :desc)}
  scope :on_day, -> (date) { where('DATE(created_at) = ?', date)}
  scope :inactive, -> {where(["scheduled_end < ?", DateTime.now])}
  scope :pending, -> {where("not completed and not dismissed")}

  #Methods

  # Class Method: return all events this week 
  def self.eventsThisWeek
  	# Populate the array with the most recent 7 days (today, tomorrow, the day after...)
  	thisWeek = []
  	date = Date.today
  	for daysAfter in 0..6 do
  		thisWeek.push([date])
  		date = date + 1
  	end
  	# Populate each day array within thisWeek with events from that day
  	for dayArray in thisWeek do
  		day = dayArray[0]
  		dayArray.push(Event.on_day(day))
  	end
  	return thisWeek
  end

end
