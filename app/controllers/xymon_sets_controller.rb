class XymonSetsController < ApplicationController
  before_action :set_xymon_set, only: [:show, :edit, :update, :destroy]

  # GET /xymon_sets
  # GET /xymon_sets.json
  def index
    @xymon_sets = XymonSet.all
    $xaslogger.info "XymonSets controller/index action : listing xymon parameters"
  end

  # GET /xymon_sets/1
  # GET /xymon_sets/1.json
  def show
  end

  # GET /xymon_sets/new
  def new
    @xymon_set = XymonSet.new
  end

  # GET /xymon_sets/1/edit
  def edit
  end

  # POST /xymon_sets
  # POST /xymon_sets.json
  def create
    @xymon_set = XymonSet.new(xymon_set_params)

    respond_to do |format|
      if @xymon_set.save
        format.html { redirect_to @xymon_set, notice: t('notice.xymon_set_created') }
        format.json { render :show, status: :created, location: @xymon_set }
        $xaslogger.info "XymonSets controller/create action : xymon parameter created"
      else
        format.html { render :new }
        format.json { render json: @xymon_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /xymon_sets/1
  # PATCH/PUT /xymon_sets/1.json
  def update
    respond_to do |format|
      if @xymon_set.update(xymon_set_params)
        format.html { redirect_to @xymon_set, notice: t('notice.xymon_set_updated') }
        format.json { render :show, status: :ok, location: @xymon_set }
        $xaslogger.info "XymonSets controller/update action : xymon parameter updated"
      else
        format.html { render :edit }
        format.json { render json: @xymon_set.errors, status: :unprocessable_entity }
      end
    end
    update_xymon(@xymon_set.name)
  end

  # DELETE /xymon_sets/1
  # DELETE /xymon_sets/1.json
  def destroy
    @xymon_set.destroy
    respond_to do |format|
      format.html { redirect_to xymon_sets_url, notice: t('notice.xymon_set_destroyed') }
      format.json { head :no_content }
      $xaslogger.info "XymonSets controller/destroy action : xymon parameter destroyed"
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_xymon_set
    @xymon_set = XymonSet.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def xymon_set_params
    params.require(:xymon_set).permit(:name, :value, :desc)
  end

  ############################################|
  #             CONF METHODS                 #|
  ############################################|

  private
  def update_xymon(selection)
    modelFile = XymonSet.where(name: "XYMON_SERVER_CONFIG_FILE").first
    file_path = modelFile.value
    modelXymonSet = XymonSet.where(name: selection).first
    set_key=modelXymonSet.name
    set_value="\"#{modelXymonSet.value}\""
    change_xymon_parameter(set_key, set_value, file_path)
  end

  private
  def change_xymon_parameter(set_key, set_value, file_path)
    file=File.open(file_path, 'r+')
    lines=file.readlines
    file.close
    file_new=File.new(file_path, 'w+')
    count=0
    lines.each do |line|
      if line.include? set_key
        if line.to_s.casecmp(set_key) == 1
          puts line
          file_new.puts set_key+"="+set_value
          count+=1
        else
          file_new.puts line
        end
      else
        file_new.puts line
      end
    end
    file_new.close
    count>0 ?
        flash[:notice] = "#{count} satır değiştirildi." :
        flash[:notice] = t('notice.file_not_found')
    $xaslogger.info "XymonSets controller/change_xymon_parameter action : change xymon parameter in #{file_path}"
  end
end
