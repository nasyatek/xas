json.array!(@network_sets) do |network_set|
  json.extract! network_set, :id, :hostname, :address, :netmask, :network, :broadcast, :gateway
  json.url network_set_url(network_set, format: :json)
end
