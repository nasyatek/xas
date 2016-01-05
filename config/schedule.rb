set :environment, "development"
set :output, "log/cron.log"
# set :output, {:error => "log/cron_error_log.log", :standard => "log/cron_log.log"}

every 2.minutes do
  puts   "CronJob : Sensor Read Period : 2 minutes"
  runner "ReadSensor.read_sensor_periodic"
end

# every 2.minutes do
#   puts "Sensor : 2 Minutes Period Test"
#   runner "ReadSensor.testcron"
# end

every 1.day, :at => '16:59 pm' do
  puts "CronJob : Daily Information"
  runner "ReadSensor.sensor_daily"
end

# Alttaki mettotlar test edildi.
# case @environment
#   when 'development'
#     every 1.minutes do
#       puts "SCHEDULED COMMAND"
#       runner "ReadSensor.testRunner"
#       command "ls -la"
#     end
# end
#
# case @environment
#   when 'development'
#     every 1.minute do
#       puts "SCHEDULED RUNNER"
#       runner "ReadSensor.testRake"
#     end
# end