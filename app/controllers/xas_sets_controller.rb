class XasSetsController < ApplicationController
  before_action :set_xas_set, only: [:show, :edit, :update, :destroy]

  # GET /xas_sets
  # GET /xas_sets.json
  def index
    @xas_sets = XasSet.all
  end

  # GET /xas_sets/1
  # GET /xas_sets/1.json
  def show
  end

  # GET /xas_sets/new
  def new
    @xas_set = XasSet.new
  end

  # GET /xas_sets/1/edit
  def edit
  end

  # POST /xas_sets
  # POST /xas_sets.json
  def create
    @xas_set = XasSet.new(xas_set_params)

    respond_to do |format|
      if @xas_set.save
        format.html { redirect_to @xas_set, notice: t('notice.xas_set_created') }
        format.json { render :show, status: :created, location: @xas_set }
      else
        format.html { render :new }
        format.json { render json: @xas_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /xas_sets/1
  # PATCH/PUT /xas_sets/1.json
  def update
    respond_to do |format|
      if @xas_set.update(xas_set_params)
        update_cronjob
        format.html { redirect_to @xas_set, notice: @notice_str }
        format.json { render :show, status: :ok, location: @xas_set }

      else
        format.html { render :edit }
        format.json { render json: @xas_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /xas_sets/1
  # DELETE /xas_sets/1.json
  def destroy
    @xas_set.destroy
    respond_to do |format|
      format.html { redirect_to xas_sets_url, notice: t('notice.xas_set_destroyed') }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_xas_set
    @xas_set = XasSet.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def xas_set_params
    params.require(:xas_set).permit(:name, :value, :desc)
  end

  private
  def update_cronjob
    $xaslogger.info "XasSet CRONJOB controller/update_cronjob action : Cronjob will be change!"
    $xaslogger.info "XasSet CRONJOB controller/update_cronjob action : Parameter : #{@xas_set.name} Alarm Limit : #{@xas_set.value} "

    if @xas_set.name.to_s.eql? "TEMPERATURE"
      $xaslogger.info "XasSet CRONJOB command output : Limit level will be change!"
      system XCommands::X_L_CD_XAS_FOLDER
      system XCommands::X_CRON_DEL
      output = IO.popen(XCommands::X_CRON_WHENEVER_UPDATE)
      output.readlines.each do |line|
        $xaslogger.info "*************    CRONJOB COMMAND OUTPUT : "+line
      end
    else
      $xaslogger.info "CRONJOB OUTPUT : Command not worked! Please check project path or run this command root of project folder : whenever --update-crontab"
    end

    cron_list_size = IO.popen(XCommands::X_CRON_LIST_SIZE)
    if cron_list_size.readlines.count>=1
      $xaslogger.info "XasSets controller/update_cronjob action : NEW CRONJOBS UPDATED"
      @notice_str = t('notice.xas_set_cronjob_ok')
    else
      $xaslogger.error "XasSets controller/update_cronjob action : THERE IS NO CRONJOBS, Please check project path or run this command root of project folder : whenever --update-crontab "
      @notice_str = t('notice.xas_set_cronjob_not_ok')
    end
  end

end


