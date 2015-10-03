json.array!(@event_recurrences) do |event_recurrence|
  json.extract! event_recurrence, :id, :event_id, :even_weeks, :odd_weeks, :yearly, :months, :days, :auto_dismiss
  json.url event_recurrence_url(event_recurrence, format: :json)
end
