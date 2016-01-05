class ReadSensor

  def self.read_sensor_periodic

    @settingTempC=XasSet.where(name: "TEMPERATURE").first
    @lastRecord=Temp.last

    @tempc="No Data"
    @tempf="No Data"
    @temph="No Data"

    system XCommands::X_T_EXPORT_RVMSUDO
    output = IO.popen(XCommands::X_T_GET_TEMP)

    @tempSensor= Temp.new
    i=1
    output.readlines.each do |line|
      puts "ReadSensor : Sensor Value : "+line.to_s
      if i == 1
        @tempc=line
        @tempSensor.tempc=@tempc
      elsif i==2
        @tempf=line
        @tempSensor.tempf=@tempf
      else
        @temph=line
        @tempSensor.temph=@temph
      end
      i=i+1
    end
    if @tempSensor.tempc.nil?
      mail= SensorMailer.sensor_cannot_read_email(@tempSensor)
      mail.deliver_now
      puts "ReadSensor : SEND MAIL : SUBJECT : CANNOT READ SENSOR!"
      @tempSensor.mark=false
    else
      if @tempSensor.tempc.to_i > @settingTempC.value.to_i
        mail= SensorMailer.sensor_params_email(@tempSensor)
        mail.deliver_now
        @tempSensor.mark=true
        puts "ReadSensor : SEND MAIL : SUBJECT : SENSOR READ AND ABNORMAL VALUES!"
      else
        puts "ReadSensor : VALUES NORMAL"
        @tempSensor.mark=false
        if @lastRecord.tempc.to_i > @settingTempC.value.to_i && @tempSensor.tempc < @settingTempC.value.to_i
          puts "ReadSensor : SEND MAIL SUBJECT : VALUES CHANGED TO NORMAL"
          mail= SensorMailer.create_sensor_value_changed_normal(@tempSensor)
          mail.deliver_now
          @tempSensor.mark=false
        end
      end
    end
    @tempSensor.save
  end

  # Günlük mail bilgilendirmesi
  def self.sensor_daily
    @tempc="No Data"
    @tempf="No Data"
    @temph="No Data"

    system XCommands::X_T_EXPORT_RVMSUDO
    output = IO.popen(XCommands::X_T_GET_TEMP)

    @tempSensor= Temp.new
    i=1
    output.readlines.each do |line|
      puts "Deger : "+line.to_s
      if i == 1
        @tempc=line
        @tempSensor.tempc=@tempc
      elsif i==2
        @tempf=line
        @tempSensor.tempf=@tempf
      else
        @temph=line
        @tempSensor.temph=@temph
      end
      i=i+1
    end
    if @tempSensor.tempc.to_i > @settingTempC.value.to_i
      @tempSensor.mark=true
    else
      @tempSensor.mark=false
    end
    @tempSensor.save
    mail= SensorMailer.sensor_daily_email(@tempSensor)
    mail.deliver_now
  end

  def self.testcron
    mail= SensorMailer.sensor_test_cron
    mail.deliver_now
  end

  # def self.testRake
  #   puts " TEST Rake "
  # end

end


