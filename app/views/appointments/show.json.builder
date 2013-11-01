json.array!(@appointments) do |appointment|
  json.extract! appointment, :date, :month, :year, :time, :desc
  json.url appointment_url(appointment, format: :json)
end
