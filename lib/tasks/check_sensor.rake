# task :ask do
#   puts "How are you ?"
# end

desc 'Greeting user'
task :xgreet do
  puts "Hello Im TASK, And you ?"
end

desc 'ask a something to user'
task :xask => :xgreet do
  puts "How are you ?"
end

desc 'Check sensor values'
task :xsensor do
  puts "Sensor taskı işletilmeye başlandı..."
  ReadSensor.testMe
end