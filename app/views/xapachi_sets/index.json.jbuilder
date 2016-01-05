json.array!(@xapachi_sets) do |xapachi_set|
  json.extract! xapachi_set, :id, :name, :value, :desc
  json.url xapachi_set_url(xapachi_set, format: :json)
end
