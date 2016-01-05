json.array!(@xmail_sets) do |xmail_set|
  json.extract! xmail_set, :id, :name, :value, :desc
  json.url xmail_set_url(xmail_set, format: :json)
end
