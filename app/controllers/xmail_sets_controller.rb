class XmailSetsController < ApplicationController
  before_action :set_xmail_set, only: [:show, :edit, :update, :destroy]

  # GET /xmail_sets
  # GET /xmail_sets.json
  def index
    @xmail_sets = XmailSet.all
    $xaslogger.info "XmailSets controller/index action : mail parameters listing"
  end

  # GET /xmail_sets/1
  # GET /xmail_sets/1.json
  def show
  end

  # GET /xmail_sets/new
  def new
    @xmail_set = XmailSet.new
  end

  # GET /xmail_sets/1/edit
  def edit
  end

  # POST /xmail_sets
  # POST /xmail_sets.json
  def create
    @xmail_set = XmailSet.new(xmail_set_params)

    respond_to do |format|
      if @xmail_set.save
        format.html { redirect_to @xmail_set, notice: t('notice.xmail_set_created') }
        format.json { render :show, status: :created, location: @xmail_set }
        $xaslogger.info "XmailSets controller/create action : mail created"
      else
        format.html { render :new }
        format.json { render json: @xmail_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /xmail_sets/1
  # PATCH/PUT /xmail_sets/1.json
  def update
    respond_to do |format|
      if @xmail_set.update(xmail_set_params)
        format.html { redirect_to @xmail_set, notice: t('notice.xmail_set_updated') }
        format.json { render :show, status: :ok, location: @xmail_set }
        $xaslogger.info "XmailSets controller/update action : mail update"
        update_xymon_alert_conf
      else
        format.html { render :edit }
        format.json { render json: @xmail_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /xmail_sets/1
  # DELETE /xmail_sets/1.json
  def destroy
    @xmail_set.destroy
    respond_to do |format|
      format.html { redirect_to xmail_sets_url, notice: t('notice.xmail_set_destroyed') }
      format.json { head :no_content }
      $xaslogger.info "XmailSets controller/destroy action : mail destroy"
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_xmail_set
    @xmail_set = XmailSet.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def xmail_set_params
    params.require(:xmail_set).permit(:name, :value, :desc)
  end

  private
  def update_xymon_alert_conf
    # Dosya yol bilgisini ve eklenecek mail adresini ilgili tablolardan alıyoruz.
    modelXymonSetAlertFile = XymonSet.where(name: "XYMON_ALERT_FILE").first
    modelXMailSet = XmailSet.where(name: "MAIL_RECEIVER_ADDRESS").first

    file_path = modelXymonSetAlertFile.value
    replace_str=modelXMailSet.value
    file = File.open(file_path, 'r+')
    lines=file.readlines
    file.close
    file_new=File.new(file_path, 'w+')
    regge = Regexp.new(/\b[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}\b/)
    changed_lines=0
    #puts line.scan(r).uniq
    lines.each do |line|
      eski_mail_adresi = line.scan(regge).uniq.first
      unless eski_mail_adresi.nil?
        line.sub!(eski_mail_adresi,replace_str)
        changed_lines+=1
      end
      file_new.puts line
    end
    file_new.close
    if changed_lines>0
      flash[:notice] = "#{changed_lines} satır değiştirildi."
      system XCommands::X_APACHE_RESTART
      system XCommands::X_XYMON_RESTART
    else
      flash[:notice] = 'Bu parametre veritabanında güncellendi, fakat ilgili dosyada bulunamadı.'
    end
    $xaslogger.info "XmailSets controller/update_xymon_alert_conf action : replace email address in xymon alert config file : #{file_path}"
  end
end