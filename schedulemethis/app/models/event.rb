class Event < ActiveRecord::Base
  # Relationships
  belongs_to :schedule
  has_many :event_instances
  has_one :event_recurrence

  # Required Fields
  validates_presence_of :short_description, :estimated_time_required, :priority

  # Scopes
  scope :closest_end_date, -> { order(end_date: :asc) }
  scope :recently_created, -> { order(created_at: :asc)}
  scope :on_day, -> (date) { where('DATE(start_date) = ?', date)}
  scope :inactive, -> {where(["scheduled_end < ?", DateTime.now])}
  scope :pending, -> {where("not completed and not dismissed")}

  def get_start_datetime
  	if !self.start_date.nil?
  		return "#{self.start_date.to_s}T#{self.start_time.hour}:#{self.start_time.min}:00"
  	end
    start_times = Event.all.map{|e| e.start_date}
  	set_date = Date.today.beginning_of_week
  	set_date_str = ""
  	while set_date_str.empty?
  	  if !start_times.include?(set_date)
        set_date_str = set_start_time(set_date, "10:30:00")
  	  else
  	    start_times.delete_at(start_times.index(set_date)) if start_times.include?(set_date)
  	    if !start_times.include?(set_date)
  	      set_date_str = set_start_time(set_date, "15:30:00")
  	    end
  	  end
  	  set_date = set_date.tomorrow
  	end
  	set_date_str
  end

  def set_start_time(set_date, time)
    self.start_date = set_date
    self.start_time = time
  	self.save
  	set_date_str = set_date.to_s + "T" + time
  end

  def get_end_time
    self.end_time = self.start_time + (self.estimated_time_required * 60)
    self.save
    "#{self.start_date.to_s}T#{self.end_time.hour}:#{self.end_time.min}:00"
  end
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
