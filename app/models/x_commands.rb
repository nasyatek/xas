module XCommands
  pass=XasSet.where(name: "PASS").first
  receiver_mail = XmailSet.where(name: "MAIL_RECEIVER_ADDRESS").first
  # "echo q1 | sudo /opt/lampp/xampp stop" we use pipe for root password.
  pass_str = "echo "+pass.value+" | sudo "
  # Test
  X_TEST_ECHO = "echo $USER"

  # Init Commands
  # CRONJOB Güncelleme
  X_CRON_DEL = "crontab -r"
  X_CRON_LIST = "crontab -l"
  X_CRON_LIST_SIZE = "crontab -l | wc -l"
  X_L_CD_XAS_FOLDER = "cd /home/pi/apps/xas"
  #X_L_CD_XAS_FOLDER = "cd /home/ay/RubymineProjects/xas"
  X_CRON_WHENEVER_UPDATE = "whenever --update-crontab"

  # SENSOR BILGILERI
  X_T_EXPORT_RVMSUDO = "export rvmsudo_secure_path=1"
  X_T_GET_TEMP = "rvmsudo ruby /sens/dht11/rubytemp"

  # BY XASPIAN
  # Apache Commands
  X_APACHE_START = pass_str + "/etc/init.d/apache2 start"
  X_APACHE_STOP = pass_str + "/etc/init.d/apache2 stop"
  X_APACHE_RESTART = pass_str+ "/etc/init.d/apache2 restart"
  X_APACHE_STATUS = pass_str+ "/etc/init.d/apache2 status"

  # Xymon Commands
  X_XYMON_START = "/var/www/server/xymon.sh start"
  X_XYMON_STOP = "/var/www/server/xymon.sh stop"
  X_XYMON_RESTART = "/var/www/server/xymon.sh restart"
  X_XYMON_STATUS = "ps aux | grep xymond | wc"

  # PostFix Commands
  X_POSTFIX_START = pass_str+"sudo /etc/init.d/postfix start"
  X_POSTFIX_STOP = pass_str+"sudo /etc/init.d/postfix stop"
  X_POSTFIX_RESTART = pass_str+"sudo /etc/ini t.d/postfix restart"
  X_POSTFIX_STATUS = pass_str+"sudo /etc/ini t.d/postfix status"
  X_SEND_TEST_MAIL = "echo 'Test maili başarıyla gönderildi.' | mail -s 'Test Mail From XBAY' "+receiver_mail.value
  X_SEND_TEST_MAILX = "echo 'Test maili başarıyla gönderildi.' | mailx -s 'Test Mail From XBAY' "+receiver_mail.value

  # " The Others :) / Linux Commands "
  X_L_CHANGE_HOSTNAME = ""
  X_L_CHANGE_IP = " "
  X_L_DISK_USAGE = "df -h /root/"
  X_L_SESSIONS = " "
  X_L_NETWORK_RESTART = "sudo /etc/init.d/networking restart"

  # BY LAMP SERVER
  # Apache Commands
  # X_APACHE_START = pass_str + "/opt/lampp/xampp start"
  # X_APACHE_STOP = pass_str + "/opt/lampp/xampp stop"
  # X_APACHE_RESTART = pass_str+ "/opt/lampp/xampp restart"

  # Xymon Commands
  # X_XYMON_START = "/var/www/server/xymon.sh start"
  # X_XYMON_STOP = "/var/www/server/xymon.sh stop"
  # X_XYMON_RESTART = "/var/www/server/xymon.sh restart" # "/xymon/server/xymon.sh restart"

  # PostFix Commands
  # X_POSTFIX_START = pass_str+"/etc/init.d/postfix start"
  # X_POSTFIX_STOP = pass_str+"/etc/init.d/postfix stop"
  # X_POSTFIX_RESTART = pass_str+"/etc/ini t.d/postfix restart"
  # X_SEND_TEST_MAIL = "echo 'Test maili başarıyla gönderildi.' | mailx -s 'Test Mail From XBAY' "+receiver_mail.value

  # " The Others :) / Linux Commands "
  # X_L_CHANGE_HOSTNAME = " "
  # X_L_CHANGE_IP = " "
  # X_L_DISK_USAGE = " "
  # X_L_SESSIONS = " "
  # X_L_NETWORK_RESTART = " "


end