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
  scope :on_day, -> (date) { where('DATE(start_date) = ?', date)}
  scope :inactive, -> {where(["scheduled_end < ?", DateTime.now])}
  scope :pending, -> {where("not completed and not dismissed")}
  scope :notcompleted, -> {where("completed IS NOT ?", true)}
  scope :completed, -> {where("completed IS ?", true)}
  scope :past, -> {where('start_date < ?', Date.today)}
  # Sort events by start time
  scope :chronological, -> { order(start_time: :asc) }

  def get_start_datetime
    user_start_time = "09:00:00"
  	if !self.start_date.nil?
  		return "#{self.start_date.to_s}T#{self.time_hours(self.start_time.hour)}:#{self.time_minutes(self.start_time.min)}:00"
  	end
  	set_date = Date.today
  	set_date_str = ""
  	while set_date_str.empty?
      todays_events = Event.on_day(set_date)
  	  if todays_events.count > 4
        set_date = set_date.tomorrow
  	  else
  	    last_end_time_event = todays_events.max_by {|e| e.end_time}
          if last_end_time_event.nil?
  	        set_date_str = set_start_time(set_date, user_start_time)
          else
            set_date_str = set_start_time(set_date, (last_end_time_event.end_time + 1200).strftime("%H:%M:%S")) #20 minutes later
  	    end
  	  end
  	end
  	set_date_str
  end

  def time_minutes(mins)
    return "00" if mins == 0
    mins
  end

  def time_hours(hours)
    return "0#{hours}" if hours.to_s.length == 1
    hours
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
    "#{self.start_date.to_s}T#{self.time_hours(self.end_time.hour)}:#{self.time_minutes(self.end_time.min)}:00"
  end
  
  #Methods
  def priority_rating
    # Return whether the priority for the event is low, medium, or high
    if(self.priority == 2)
      return "High"
    elsif(self.priority == 1)
      return "Medium"   
    else
      return "Low"
    end
  end

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
      # Put events from that day in chronological order and then push to array
  		dayArray.push(Event.on_day(day).chronological)
  	end
  	return thisWeek
  end

  def self.remainingEventsToday
    return Event.on_day(Date.today).notcompleted.chronological
  end

end
