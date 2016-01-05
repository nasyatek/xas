# noinspection ALL
class ConsoleController < ApplicationController

  @@log_line_number = 0

  def index
  end

  ##################################
  #     RECREATE CONFIG FILES      #
  ##################################

  def recreate_xas_host_file
    modelXymonSet=XymonSet.where(name: "XYMON_HOST_FILE").first
    $xaslogger.info "Console Sayfası Açıldı... : "+modelXymonSet.value
    @files = Dir.glob(modelXymonSet.value)
    input_file_name = modelXymonSet.value

    # Dosyayı açıp içeriği alıyoruz
    file=File.open(input_file_name, 'w+')

    @groups=Group.order("index_number").all

    @groups.each { |g|
      # Yorum satırı olacaksa, satırbaşına # ekleniyor.
      g.status ? str = "group   " : str = "# group   "
      file.puts str+g.name+"    #  "+g.note

      g.servers.order("index_number").each { |s|
        # If server not active, we add # and convert line to comment line
        s.status ? str="    " : str="  # "
        note= s.note ? s.note : ""
        file.puts str+s.ip+"   "+s.hostname+"    # "+ note
        puts "Server : "+str+s.ip+"  "+s.hostname+"   # "+s.note
      }
      # Grup tanımından sonra bir satır boşluk bırakılıyor.
      file.puts " "
    }
    file.close
    # INFO
    @@log_line_number += 1
    result=@@log_line_number.to_s + " : " + Time.now.to_s+" : "+"Dosya içeriği veritabanından alınan içerikle yeniden oluşturuldu."
    respond_to do |format|
      format.json { render :json => {:result => result} }
    end
    $xaslogger.info "Console controller/recreate_xas_host_file action : recreate xymon host file #{input_file_name}"
  end

  def recreate_apache_config
    result=@@log_line_number.to_s + " : " + Time.now.to_s+" : "+"Apche File Recreate : Not Implemented"
    respond_to do |format|
      format.json { render :json => {:result => result} }
    end
    $xaslogger.info "Console controller/recreate_apache_config action : Not Implemented method"
  end

  ##################################
  #        SERVER COMMANDS         #
  ##################################

  # ALL IN ONE
  def start_all_system
    result = ""

    @@log_line_number += 1
    system XCommands::X_APACHE_START

    if $?.exitstatus == 0
      result=@@log_line_number.to_s + " : " + Time.now.to_s+ " : "+t('console_screen.start_apache')+" \n"
    end

    @@log_line_number += 1
    system XCommands::X_XYMON_START
    if $?.exitstatus == 0
      result = result + @@log_line_number.to_s + " : " + Time.now.to_s+ " :"+t('console_screen.xymon_start')+" \n"
    end

    @@log_line_number += 1
    system XCommands::X_POSTFIX_START
    if $?.exitstatus == 0
      result = result + @@log_line_number.to_s + " : " + Time.now.to_s+ " : "+t('console_screen.postfix_start')+"\n"
    end

    result = result+ @@log_line_number.to_s + " : " + Time.now.to_s+ t('console_screen.system_was_success_started')
    respond_to do |format|
      format.json { render :json => {:result => result} }
    end
    $xaslogger.info "Console controller/start_all_system action : #{result}"

  end

  def stop_all_system
    result =""
    @@log_line_number += 1
    if system XCommands::X_APACHE_STOP
      if $?.exitstatus == 0
        result = result + t('console_screen.apache_stop')
      else
        result = result + t('console_screen.apache_cant_stop')+"\n"
      end
    else
      puts "Apache Sunucu Durdurulamadı, Sistemde Yüklü Olmayabilir! \n"
      result = result + t('console_screen.apache_cant_stop_maybe_not_installed')+"\n"
    end

    @@log_line_number += 1
    if system XCommands::X_XYMON_STOP
      if $?.exitstatus == 0
        result = result + t('console_screen.xymon_stop')
      else
        result = result + t('console_screen.xymon_cant_stop')
      end
    else
      puts "Xymon Sunucu Durdurulamadı, Sistemde Yüklü Olmayabilir! \n"
      result = result + t('console_screen.xymon_cant_stop_maybe_not_installed')+"\n"
    end


    @@log_line_number += 1
    if system XCommands::X_POSTFIX_STOP
      if $?.exitstatus == 0
        result = result + t('console_screen.postfix_stop')
      else
        result = result + t('console_screen.postfix_cant_stop')
      end
    else
      puts "Postfix Durdurulamadı, Sistemde Yüklü Olmayabilir! \n "
      result = result + t('console_screen.postfix_cant_stop_maybe_not_installed')+"\n"
    end

    result = result+ @@log_line_number.to_s + " : " + Time.now.to_s+ t('console_screen.all_command_tried')
    respond_to do |format|
      format.json { render :json => {:result => result} }
    end
    $xaslogger.info "Console controller/stop_all_system action : #{result}"
  end

  ### Servers ###
  # Apache
  def apache_start
    system XCommands::X_APACHE_START
    @@log_line_number += 1
    result=@@log_line_number.to_s + " : " + Time.now.to_s+" : "
    if $?.exitstatus == 0
      result = result + t('console_screen.apache_start')
    else
      result = result + t('console_screen.apache_cant_start')
    end
    respond_to do |format|
      format.json { render :json => {:result => result} }
    end
    $xaslogger.info "Console controller/apache_start action : #{result}"
  end

  def apache_stop

    system XCommands::X_APACHE_STOP
    @@log_line_number += 1
    result=@@log_line_number.to_s + " : " + Time.now.to_s+" : "
    if $?.exitstatus == 0
      result = result + t('console_screen.apache_stop')
    else
      result = result + t('console_screen.apache_cant_stop')
    end
    respond_to do |format|
      format.json { render :json => {:result => result} }
    end
    $xaslogger.info "Console controller/apache_stop action : #{result}"
  end

  def apache_restart

    system XCommands::X_APACHE_RESTART
    @@log_line_number += 1
    result=@@log_line_number.to_s + " : " + Time.now.to_s+" : "
    if $?.exitstatus == 0
      result = result + t('console_screen.apache_restart')
    else
      result = result + t('console_screen.apache_cant_restart')
    end
    respond_to do |format|
      format.json { render :json => {:result => result} }
    end
    $xaslogger.info "Console controller/apache_restart action : #{result}"
  end

  def apache_status
    system XCommands::X_APACHE_STATUS
    @@log_line_number += 1
    result=@@log_line_number.to_s + " : " + Time.now.to_s+" : "
    if $?.exitstatus == 0
      result = result + t('console_screen.apache_status')+": "+t('console_screen.not_implemented')
    else
      result = result + t('console_screen.apache_status')+": "+t('console_screen.not_implemented')
    end
    respond_to do |format|
      format.json { render :json => {:result => result} }
    end
    $xaslogger.info "Console controller/apache_status action : #{result}"
  end

  def xymon_start

    system XCommands::X_XYMON_START
    result=@@log_line_number.to_s + " : " + Time.now.to_s+" : "
    if $?.exitstatus == 0
      result = result + t('console_screen.xymon_start')
    else
      result = result + t('console_screen.xymon_cant_start')
    end
    respond_to do |format|
      format.json { render :json => {:result => result} }
    end
    $xaslogger.info "Console controller/xymon_start action : #{result}"
  end


  def xymon_stop

    system XCommands::X_XYMON_STOP
    result=@@log_line_number.to_s + " : " + Time.now.to_s+" : "
    if $?.exitstatus == 0
      result = result + t('console_screen.xymon_stop')
    else
      result = result + t('console_screen.xymon_cant_stop')
    end
    respond_to do |format|
      format.json { render :json => {:result => result} }
    end
    $xaslogger.info "Console controller/xymon_stop action : #{result}"
  end

  def xymon_restart

    system XCommands::X_XYMON_RESTART
    result=@@log_line_number.to_s + " : " + Time.now.to_s+" : "
    if $?.exitstatus == 0
      result = result + t('console_screen.xymon_restart')
    else
      result = result + t('console_screen.xymon_cant_restart')
    end
    respond_to do |format|
      format.json { render :json => {:result => result} }
    end
    $xaslogger.info "Console controller/xymon_restart action : #{result}"
  end

  def xymon_status

    system XCommands::X_XYMON_STATUS
    result=@@log_line_number.to_s + " : " + Time.now.to_s+" : "
    if $?.exitstatus == 0
      result = result + t('console_screen.xymon_status')+": "+t('console_screen.not_implemented')
    else
      result = result + t('console_screen.xymon_status')+": "+t('console_screen.not_implemented')
    end
    respond_to do |format|
      format.json { render :json => {:result => result} }
    end
    $xaslogger.info "Console controller/xymon_status action : #{result}"
  end

  def postfix_start

    system XCommands::X_POSTFIX_START
    result=@@log_line_number.to_s + " : " + Time.now.to_s+" : "
    if $?.exitstatus == 0
      result = result + t('console_screen.postfix_start')
    else
      result = result + t('console_screen.postfix_cant_start')
    end
    respond_to do |format|
      format.json { render :json => {:result => result} }
    end
    $xaslogger.info "Console controller/postfix_start action : #{result}"
  end

  def postfix_stop

    system XCommands::X_POSTFIX_STOP
    result=@@log_line_number.to_s + " : " + Time.now.to_s+" : "
    if $?.exitstatus == 0
      result = result + t('console_screen.postfix_stop')
    else
      result = result + t('console_screen.postfix_cant_stop')
    end
    respond_to do |format|
      format.json { render :json => {:result => result} }
    end
    $xaslogger.info "Console controller/postfix_stop action : #{result}"
  end

  def postfix_restart

    system XCommands::X_POSTFIX_RESTART
    result=@@log_line_number.to_s + " : " + Time.now.to_s+" : "
    if $?.exitstatus == 0
      result = result + t('console_screen.postfix_restart')
    else
      result = result + t('console_screen.postfix_cant_restart')
    end
    respond_to do |format|
      format.json { render :json => {:result => result} }
    end
    $xaslogger.info "Console controller/postfix_restart action : #{result}"
  end

  def postfix_status

    system XCommands::X_POSTFIX_STATUS
    result=@@log_line_number.to_s + " : " + Time.now.to_s+" : "
    if $?.exitstatus == 0
      result = result + t('console_screen.postfix_status')+": "+t('console_screen.not_implemented')
    else
      result = result + t('console_screen.postfix_status')+": "+t('console_screen.not_implemented')
    end
    respond_to do |format|
      format.json { render :json => {:result => result} }
    end
    $xaslogger.info "Console controller/postfix_status action : #{result}"
  end

end