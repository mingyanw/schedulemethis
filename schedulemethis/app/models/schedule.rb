class Schedule < ActiveRecord::Base
  # Relationships
  belongs_to :user
  has_many :events

  # Scopes
  
end
