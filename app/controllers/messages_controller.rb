class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    MessageMailer.new_message(@message).deliver_now
    redirect_to welcome_dashboard_path, notice: t('notice.mailer_mail_send')
    $xaslogger.info "Message controller/create action : Message created"
  end

  private
  def message_params
    params.require(:message).permit(:name, :email, :body, :subject)
  end
end
