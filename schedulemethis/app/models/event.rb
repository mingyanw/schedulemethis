class Event < ActiveRecord::Base
  belongs_to :schedule
  has_many :event_instances
  has_one :event_recurrence

  validates_presence_of :short_description, :estimated_time_required, :priority

  scope :closest_end_date, -> { order(end_date: :asc) }
  scope :recently_created, -> { order(created_at: :desc)}
  scope :on_day, -> (date) { where('DATE(created_at) = ?', date)}
  scope :inactive, -> {where(["scheduled_end < ?", DateTime.now])}
  scope :pending, -> {where("not completed and not dismissed")}
end
