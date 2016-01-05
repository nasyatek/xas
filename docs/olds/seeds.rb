# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
# ADEM HICDURMAZ ademhicdurmaz@gmail.com

###################################################################################
#                                                                                 #
#                            SYSTEM VARIABLES                                     #
#                                                                                 #
###################################################################################
# SYSTEM ROOT PASS
Setting.create(name: 'SYSTEM_PASSWORD', value: 'q1')

# Sensor Values
Setting.create(name: 'TEMPERATURE', value: '18')
Setting.create(name: 'FAHRENHEIT', value: '77')
Setting.create(name: 'HUMIDITY', value: '50')

# Company Info
Setting.create(name: 'COMPANY', value: 'RASPIAN')

# NETWORK VARIABLES
Setting.create(name: 'HOSTNAME', value: 'kutlubilgi.com')
Setting.create(name: 'IP_NUMBER', value: '192.168.13.13')

# APACHE VARIABLES
Setting.create(name: 'APACHE_PORT', value: '1299')

# XYMON VARIABLES
Setting.create(name: 'XYMON_HOST_FILE', value: 'docs/hosts.cfg')
Setting.create(name: 'XYMON_SERVER_CONFIG_FILE', value: 'docs/xymonserver.cfg')
Setting.create(name: 'XYMON_SMS_NUMBER', value: '0532 555 55 55')
Setting.create(name: 'XYMON_COMMAND_START', value: '/var/www/server/etc/xymon.sh start')

# POSTFIX VARIABLES
Setting.create(name: 'MAIL_SENDER_ADDRESS', value: 'xbay@xbay.com')
Setting.create(name: 'MAIL_RECEIVER_ADDRESS', value: 'ademhicdurmaz@hotmail.com')

# HTML VARIABLES
Setting.create(name: 'XYMON_HTML_TITLE', value: 'x-bay')
Setting.create(name: 'XYMON_HTML_HEADER', value: 'x-bay')
Setting.create(name: 'XYMON_HTML_FOOTER', value: 'x-bay')


# THE OTHERS
Setting.create(name: 'FILE_HEADER', value: '# ADEM HİÇDURMAZ - Bu dosya db kayıtlarına göre otomatik oluşturulur.')
Setting.create(name: 'LOG_FILE', value: '/var/log/xymonlog')

###################################################################################
#                                                                                 #
#                            MODEL SEEDS                                          #
#                                                                                 #
###################################################################################

# TODOLIST SAMPLE
TodoList.create(note: 'BAYKUS HDD DISK ARTTRIMI', active: false)
TodoList.create(note: 'XBAY UPDATE', active: false)
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