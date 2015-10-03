json.array!(@events) do |event|
  json.extract! event, :id, :short_description, :description, :start_date, :end_date, :start_time, :end_time, :start_time_flex_amount, :end_time_flex_amount, :priority, :may_split, :estimated_time_required, :location
  json.url event_url(event, format: :json)
end
