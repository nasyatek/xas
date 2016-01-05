class SensorMailer < ApplicationMailer

  @modelMailFrom = XmailSet.where(name: 'MAIL_SENDER_ADDRESS').first
  @modelMailTo = XmailSet.where(name: 'MAIL_RECEIVER_ADDRESS').first
  @networkInfo = NetworkSet.first

  default from: @modelMailFrom.value
  default to: @modelMailTo.value

  def sensor_params_email(tempSensor)
    setting=XasSet.where(name: "COMPANY").first
    company_name = setting.value
    @tempSensor=Temp.new
    @tempSensor=tempSensor
    mail(subject: company_name+":"+t('mailer.sensor_subject_alert'))
    $xaslogger.info "SensorMailer mailer/sensor_params_email action : sent sensor parameters as a mail"
  end

  def sensor_cannot_read_email(tempSensor)
    setting=XasSet.where(name: "COMPANY").first
    company_name = setting.value
    @tempSensor=Temp.new
    @tempSensor=tempSensor
    mail(subject: company_name+":"+t('mailer.sensor_subject_no_data'))
    $xaslogger.info "SensorMailer mailer/sensor_cannot_read_email action : sent sensor parameters as a mail"
  end

  def sensor_value_changed_normal(tempSensor)
    setting=XasSet.where(name: "COMPANY").first
    company_name = setting.value
    @tempSensor=Temp.new
    @tempSensor=tempSensor
    mail(subject: company_name+":"+t('mailer.sensor_subject_alert'))
    $xaslogger.info "SensorMailer mailer/sensor_value_changed_normal action : sent sensor parameters as a mail about normal status"
  end

  def sensor_daily_email(tempSensor)
    setting=XasSet.where(name: "COMPANY").first
    company_name = setting.value
    @tempSensor=Temp.new
    @tempSensor=tempSensor
    mail(subject: company_name+":"+t('mailer.sensor_subject_daily'))
    $xaslogger.info "SensorMailer mailer/sensor_daily_email action : sent sensor parameters as a daily mail"
  end

  def sensor_test_cron
    mail(subject: t('mailer.sensor_cron_test'))
  end

end
