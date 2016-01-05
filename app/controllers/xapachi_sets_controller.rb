class XapachiSetsController < ApplicationController
  before_action :set_xapachi_set, only: [:show, :edit, :update, :destroy]

  # GET /xapachi_sets
  # GET /xapachi_sets.json
  def index
    @xapachi_sets = XapachiSet.all
    $xaslogger.info "XapachiSet controller/create action : apache parameter created"
  end

  # GET /xapachi_sets/1
  # GET /xapachi_sets/1.json
  def show
  end

  # GET /xapachi_sets/new
  def new
    @xapachi_set = XapachiSet.new
  end

  # GET /xapachi_sets/1/edit
  def edit
  end

  # POST /xapachi_sets
  # POST /xapachi_sets.json
  def create
    @xapachi_set = XapachiSet.new(xapachi_set_params)

    respond_to do |format|
      if @xapachi_set.save
        format.html { redirect_to @xapachi_set, notice: t('notice.xapachi_set_created') }
        format.json { render :show, status: :created, location: @xapachi_set }
        $xaslogger.info "XapachiSet controller/create action : apache parameter created"
      else
        format.html { render :new }
        format.json { render json: @xapachi_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /xapachi_sets/1
  # PATCH/PUT /xapachi_sets/1.json
  def update
    respond_to do |format|
      if @xapachi_set.update(xapachi_set_params)
        format.html { redirect_to @xapachi_set, notice: t('notice.xapachi_set_updated') }
        format.json { render :show, status: :ok, location: @xapachi_set }
        $xaslogger.info "XapachiSet controller/update action : apache parameter updated"
        update_apache_file
      else
        format.html { render :edit }
        format.json { render json: @xapachi_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /xapachi_sets/1
  # DELETE /xapachi_sets/1.json
  def destroy
    @xapachi_set.destroy
    respond_to do |format|
      format.html { redirect_to xapachi_sets_url, notice: t('notice.xapachi_set_destroyed') }
      format.json { head :no_content }
      $xaslogger.info "XapachiSet controller/destroy action : apache parameter destroyed"
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_xapachi_set
    @xapachi_set = XapachiSet.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def xapachi_set_params
    params.require(:xapachi_set).permit(:name, :value, :desc)
  end

  private
  def update_apache_file
    modelFile = XapachiSet.where(name: "APACHE_PORTS_CFG_FILE").first
    modelPort = XapachiSet.where(name: "APACHE_PORT").first
    file_path = modelFile.value
    set_key=modelPort.name
    set_value=modelPort.value
    change_apache_parameter(set_key, set_value, file_path)
  end

  private
  def change_apache_parameter(set_key, set_value, file_path)
    set_key="Listen"
    count=0
    begin
      file=File.open(file_path, 'r+')
      lines=file.readlines
      file.close
      file_new=File.new(file_path, 'w+')

      lines.each do |line|
        if line.include? set_key
          if line.to_s.casecmp(set_key) == 1
            puts line
            file_new.puts set_key+" "+set_value
            count+=1
          else
            file_new.puts line
          end
        else
          file_new.puts line
        end
      end
      if count>0
        flash[:notice] = "#{count} satır değiştirildi."
        system XCommands::X_APACHE_RESTART
      else
        flash[:notice] = 'Bu parametre veritabanında güncellendi, fakat ilgili dosyada bulunamadı.'
      end
      $xaslogger.info "XapachiSet controller/change_apache_parameter action : apache parameter changed on apache config file : #{file_path}"
    rescue Errno::EACCES => e
      puts e
      $xaslogger.info "XapachiSet controller/change_apache_parameter action : File not found! : #{file_path} : #{e}"
    ensure
      file_new.close unless file_new.nil?
    end
  end
end