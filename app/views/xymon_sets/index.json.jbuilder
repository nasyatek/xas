json.array!(@xymon_sets) do |xymon_set|
  json.extract! xymon_set, :id, :name, :value, :desc
  json.url xymon_set_url(xymon_set, format: :json)
end
