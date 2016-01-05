json.array!(@servers) do |server|
  json.extract! server, :id, :ip, :hostname, :status, :note
  json.url server_url(server, format: :json)
end
