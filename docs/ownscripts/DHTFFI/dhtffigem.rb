require "dht-sensor-ffi"
val = DhtSensor.read(4, 11) # pin=4, sensor type=DHT-22
puts val.temp # => 21.899999618530273 (temp in C)
puts val.temp_f # => 71.4199993133545 (temp in F)
puts val.humidity # => 22.700000762939453 (relative humidity %)
