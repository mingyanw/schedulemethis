json.array!(@event_instances) do |event_instance|
  json.extract! event_instance, :id, :event_id, :completed, :dismissed, :scheduled_start, :scheduled_end, :location
  json.url event_instance_url(event_instance, format: :json)
end
