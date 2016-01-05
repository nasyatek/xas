class MessageMailer < ApplicationMailer
  default from: "xas@nasyatek.com"
  default to: "ahicdurmaz@tersan.com.tr"

  def new_message(message)
    @message = message
    mail(to: @message.email, subject: @message.subject)
    $xaslogger.info "Message mailer/new_message action : sent message used dasboard quickmail form"
  end

end