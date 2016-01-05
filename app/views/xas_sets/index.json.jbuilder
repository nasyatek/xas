json.array!(@xas_sets) do |xas_set|
  json.extract! xas_set, :id, :name, :value, :desc
  json.url xas_set_url(xas_set, format: :json)
end
