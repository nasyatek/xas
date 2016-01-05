# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
# ADEM HICDURMAZ ademhicdurmaz@gmail.com

###################################################################################
#                                                                                 #
#                            SYSTEM VARIABLES                                     #
#                                                                                 #
###################################################################################
#####################################
#           XAS GLOBAL              #
#####################################
# COMPANY
XasSet.create(name: 'COMPANY', value: 'NSY')
# SYSTEM ROOT PASS
XasSet.create(name: 'PASS', value: 'q1')
# Sensor Values
XasSet.create(name: 'TEMPERATURE', value: '18')
XasSet.create(name: 'FAHRENHEIT', value: '77')
XasSet.create(name: 'HUMIDITY', value: '50')

# NETWORK VARIABLES
NetworkSet.create(hostname: 'kutlubilgi.com', address: '10.0.0.18', netmask: '255.255.254.0', network: '10.0.0.0', broadcast: '10.0.1.255', gateway: '10.0.0.1', file_path: 'docs/sampleconf/interfaces')
#####################################
#           XYMON                   #
#####################################
# XYMON VARIABLES
XymonSet.create(name: 'XYMON_HOST_FILE', value: 'docs/hosts.cfg')
XymonSet.create(name: 'XYMON_SERVER_CONFIG_FILE', value: 'docs/xymonserver.cfg')
XymonSet.create(name: 'XYMON_ALERT_FILE', value: 'docs/sampleconf/alerts.cfg')

# XYMON HTML VARIABLES
XymonSet.create(name: 'XYMONLOGO', value: 'XAS')
XymonSet.create(name: 'XYMONBODYFOOTER', value: 'Powered By NSY')
XymonSet.create(name: 'XYMONALLOKTEXT', value: '<FONT SIZE=+2 FACE=\"Arial, Helvetica\"><BR><BR><I>All Monitored Systems OK</I></FONT><BR><BR>')


#####################################
#           APACHE                  #
#####################################
# APACHE VARIABLES
XapachiSet.create(name: 'APACHE_PORT', value: '1299')
XapachiSet.create(name: 'APACHE_PORTS_CFG_FILE', value: 'docs/sampleconf/ports.conf')

#####################################
#      POSTFIX MAIL SERVER          #
#####################################

# POSTFIX VARIABLES
XmailSet.create(name: 'MAIL_SENDER_ADDRESS', value: 'xas@nasyatek.com')
XmailSet.create(name: 'MAIL_RECEIVER_ADDRESS', value: 'ahicdurmaz@tersan.com.tr')

###################################################################################
#                                                                                 #
#                            MODEL SEEDS                                          #
#                                                                                 #
###################################################################################

# TODOLIST SAMPLE
TodoList.create(note: 'BAYKUS HDD DISK ARTTRIMI', active: false)
TodoList.create(note: 'XAS SYSTEM UPDATE', active: false)
TodoList.create(note: 'SERVIS DUZENELEMELERI', active: false)
TodoList.create(note: 'FIZIKSEL SUNUCU ICIN RAM TAKILACAK', active: false)
TodoList.create(note: 'KLONLAMA YAPILACAK', active: false)
TodoList.create(note: 'STORAGE ISCSI BAĞLANTISI', active: false)
TodoList.create(note: 'SWITCH CONTROL', active: false)
TodoList.create(note: 'FIREWALL CONTROL', active: false)

# GROUP SAMPLE
Group.create(name: 'LINUX', index_number: 1, status: true, note: 'Linux Machines')
Group.create(name: 'WINS', index_number: 2, status: true, note: 'Windows Machines')
Group.create(name: 'STORAGE', index_number: 3, status: true, note: 'Storages')


# SERVER SAMPLE
# LIN
Server.create(ip: "10.0.0.1", hostname: "PIRIREIS", note: "Note", status: true, index_number: 1, group_id: 1)
Server.create(ip: "10.0.0.2", hostname: "BARBAROS", note: "Note", status: true, index_number: 2, group_id: 1)
Server.create(ip: "10.0.0.3", hostname: "ORUCREIS", note: "Note", status: true, index_number: 3, group_id: 1)

# WIN
Server.create(ip: "10.0.0.4", hostname: "SAHINGOZ", note: "Note", status: true, index_number: 1, group_id: 2)
Server.create(ip: "10.0.0.5", hostname: "BAYKUS", note: "Note", status: true, index_number: 2, group_id: 2)
Server.create(ip: "10.0.0.6", hostname: "PITON", note: "Note", status: true, index_number: 3, group_id: 2)

# STORAGE
Server.create(ip: "10.0.0.7", hostname: "HANGAR", note: "Note", status: true, index_number: 1, group_id: 3)

#############################################################
# XAS CONF BITINCE  ALTTAKI KISIM SILINECEK
#############################################################
###################################################################################
#                                                                                 #
#                            SYSTEM VARIABLES                                     #
#                                                                                 #
###################################################################################
# SYSTEM ROOT PASS
Setting.create(name: 'SYSTEM_PASSWORD', value: 'q1')

# Sensor Values
Setting.create(name: 'TEMPERATURE', value: '20')
Setting.create(name: 'FAHRENHEIT', value: '77')
Setting.create(name: 'HUMIDITY', value: '50')

# Company Info
Setting.create(name: 'COMPANY', value: 'RASPIAN')

# NETWORK VARIABLES
Setting.create(name: 'HOSTNAME', value: 'kutlubilgi.com')
Setting.create(name: 'IP_NUMBER', value: '192.168.13.13')
Setting.create(name: 'LINUX_INTERFACE_FILE', value: 'docs/sampleconf/interfaces')
Setting.create(name: 'LINUX_HOSTNAME_FILE', value: 'docs/sampleconf/hostname')
Setting.create(name: 'LINUX_HOSTS_FILE', value: 'docs/sampleconf/hosts')

# APACHE VARIABLES
Setting.create(name: 'APACHE_PORT', value: '1299')

# XYMON VARIABLES
Setting.create(name: 'XYMON_HOST_FILE', value: 'docs/hosts.cfg')
Setting.create(name: 'XYMON_SERVER_CONFIG_FILE', value: 'docs/xymonserver.cfg')
Setting.create(name: 'XYMON_SMS_NUMBER', value: '0532 555 55 55')
Setting.create(name: 'XYMON_COMMAND_START', value: '/var/www/server/etc/xymon.sh start')

# POSTFIX VARIABLES
Setting.create(name: 'MAIL_SENDER_ADDRESS', value: 'xas@nasyatek.com')
Setting.create(name: 'MAIL_RECEIVER_ADDRESS', value: 'adem@nasyatek.com')

# HTML VARIABLES
Setting.create(name: 'XYMON_HTML_TITLE', value: 'XAS')
Setting.create(name: 'XYMON_HTML_HEADER', value: 'XAS')
Setting.create(name: 'XYMON_HTML_FOOTER', value: 'XAS')


# THE OTHERS
Setting.create(name: 'FILE_HEADER', value: '# ADEM HİÇDURMAZ - Bu dosya db kayıtlarına göre otomatik oluşturulur.')
Setting.create(name: 'LOG_FILE', value: '/var/log/xymonlog')
Temp.create(tempc: 22.68, tempf: 78.67, temph: 26.98, mark: false)
