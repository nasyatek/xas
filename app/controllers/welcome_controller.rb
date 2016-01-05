class WelcomeController < ApplicationController

  def dashboard
    @groups=Group.all
    @servers= Server.all
    @todoList= TodoList.last(6)
    @tempSensor=readSensors
    get_disk_info
    get_temp_averages
  end

  def readSensors
    puts "DHT11 Sensor Bilgileri Okunuyor..."
    system XCommands::X_T_EXPORT_RVMSUDO
    output = IO.popen(XCommands::X_T_GET_TEMP)
    @tempSensor= Temp.new
    i=1
    output.readlines.each do |line|
      if i == 1
        @tempSensor.tempc=line
      elsif i==2
        @tempSensor.tempf=line
      else
        @tempSensor.temph=line
      end
      i=i+1
    end
    $xaslogger.info "Welcome controller/read_sensor action : sensor read"
    return @tempSensor
  end

  def monitor
    $xaslogger.info "Welcome controller/monitor action : Xymon monitor window showing as a frame in monitor view"
  end

  def temp_history
    @array_tempc_values = Temp.all.where(:created_at => 0.days.ago.at_beginning_of_day..0.days.ago.at_end_of_day).where.not(:tempc => nil).order("created_at DESC")
    $xaslogger.info "Welcome controller/temp_history action : #{@array_tempc_values.size} get values from database"
  end


  def alarms
    @alarms=Temp.all.where(:mark => [nil, true]).order("created_at DESC")
    @alarms.each do |a|
      a.mark=false
      a.save
    end
    $xaslogger.info "Welcome controller/alarms action : #{@alarms.size} get values from database as a new mark"
  end

  private
  def get_disk_info
    output_disk_info = XCommands::X_L_DISK_USAGE
    puts output_disk_info
    output = %x{#{output_disk_info}}.split
    @disk_used = output[9].chop.to_i
    @disk_avail = output[10].chop.to_i
    @disk_avail_percent = output[11].chop.to_i
    @disk_used_percent = 100-@disk_avail_percent
    @disk_size = @disk_used+@disk_avail
    $xaslogger.info "Welcome controller/get_disk_info action : get disk usage info"
  end

  private
  def get_temp_averages
    # Günlük ortalama sıcaklık değerlerini tutan array,
    # Bu günden başlayarak geriye doğru son 7 gün ismini tutan array
    # today değişkeni, bu günün sayısal değerini tutuyor. Böylece i18n'den bu günün adını alıyoruz.
    # Bu günden geriye doğru son 7 gün ismini array'e depoluyoruz. Döngüyü 1'den başlattığımı için
    # i değerinden 1 çıkarıyoruz.
    @array_tempc_averages = Array.new
    @array_temph_averages = Array.new
    @day_names = Array.new
    today = Date.today.wday
    (1..7).each do |i|

      tmpStr= Date::ABBR_DAYNAMES[today-(i-1)].downcase
      @day_names.push(t('day_name_of_week.'+tmpStr))
      derece = Temp.all.where(:created_at => (i).days.ago.at_beginning_of_day..(i).days.ago.at_end_of_day).where.not(:tempc => nil).average(:tempc)
      nem = Temp.all.where(:created_at => (i).days.ago.at_beginning_of_day..(i).days.ago.at_end_of_day).where.not(:temph => nil).average(:temph)

      unless derece.nil?
        @array_tempc_averages.push(derece.round(2))
      else
        @array_tempc_averages.push(-273)
        flash.now[:notice] ="#{tmpStr} günü için henüz bir veri oluşmadı."
      end
      unless nem.nil?
        @array_temph_averages.push(nem.round(2))
      else
        @array_temph_averages.push(-100)
        flash.now[:notice] ="#{tmpStr} günü için henüz bir veri oluşmadı."
      end
    end
    $xaslogger.info "Welcome controller/get_temp_averages action : get last 7 days tempc value for line chart"
  end
end