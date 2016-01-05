class NetworkSetsController < ApplicationController
  before_action :set_network_set, only: [:show, :edit, :update, :destroy]

  # GET /network_sets
  # GET /network_sets.json
  def index
    @network_sets = NetworkSet.all
    $xaslogger.info "NetworkSet controller/index action : listing network parameters"
  end

  # GET /network_sets/1
  # GET /network_sets/1.json
  def show
  end

  # GET /network_sets/new
  def new
    @network_set = NetworkSet.new
  end

  # GET /network_sets/1/edit
  def edit
  end

  # POST /network_sets
  # POST /network_sets.json
  def create
    @network_set = NetworkSet.new(network_set_params)

    respond_to do |format|
      if @network_set.save
        format.html { redirect_to @network_set, notice: t('notice.network_set_created') }
        format.json { render :show, status: :created, location: @network_set }
        $xaslogger.info "NetworkSet controller/create : network parameter created"
      else
        format.html { render :new }
        format.json { render json: @network_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /network_sets/1
  # PATCH/PUT /network_sets/1.json
  def update
    respond_to do |format|
      if @network_set.update(network_set_params)
        format.html { redirect_to @network_set, notice: t('notice.network_set_updated') }
        format.json { render :show, status: :ok, location: @network_set }
        update_network
      else
        format.html { render :edit }
        format.json { render json: @network_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /network_sets/1
  # DELETE /network_sets/1.json
  def destroy
    @network_set.destroy
    respond_to do |format|
      format.html { redirect_to network_sets_url, notice: t('notice.network_set_destroyed') }
      format.json { head :no_content }
      $xaslogger.info "NetworkSet controller/destroy : network parameter destroyed"
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_network_set
    @network_set = NetworkSet.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def network_set_params
    params.require(:network_set).permit(:hostname, :address, :netmask, :network, :broadcast, :gateway)
  end

  ############################################|
  #             CONF METHODS                 #|
  ############################################|

  private
  def update_network
    flash[:notice] = t('notice.network_set_conf_change')
    modelInterfaceFile = Setting.where(name: "LINUX_INTERFACE_FILE").first
    modelHostnameFile = Setting.where(name: "LINUX_HOSTNAME_FILE").first
    modelHostsFile = Setting.where(name: "LINUX_HOSTS_FILE").first
    network_file_path = modelInterfaceFile.value
    hostname_file_path = modelHostnameFile.value
    hosts_file_path = modelHostsFile.value
    change_network_parameter("address", @network_set.address, network_file_path)
    change_network_parameter("netmask", @network_set.netmask, network_file_path)
    change_network_parameter("network", @network_set.network, network_file_path)
    change_network_parameter("broadcast", @network_set.broadcast, network_file_path)
    change_network_parameter("gateway", @network_set.gateway, network_file_path)
    change_hostname(hostname_file_path)
    update_hosts_file(hosts_file_path)
    restart_network
    $xaslogger.info "NetworkSet controller/update_network action : Network parameters updated"
  end

  private
  def change_network_parameter(set_key, set_value, file_path)
    begin
      file=File.open(file_path, 'r+')
      lines=file.readlines
      file.close
      file_new=File.new(file_path, 'w+')
      count=0
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
      file_new.close
      count>0 ?
          flash[:notice] = "#{count} satır değiştirildi." :
          flash[:notice] = t('notice.file_not_found')
      $xaslogger.info "NetworkSet controller/change_network_parameter : #{count} row updated"
    rescue Errno::EACCES => e
      $xaslogger.info "NetworkSets controller/change_network_parameter action : File not found! : #{file_path} : #{e}"
    end
  end

  private
  def change_hostname(file_path)
    file_new=File.new(file_path, 'w+')
    file_new.puts @network_set.hostname
    file_new.close
    $xaslogger.info "NetworkSet controller/change_hostname : change hostname file"
  end

  private
  def update_hosts_file(file_path)
    file=File.open(file_path, 'r+')
    lines=file.readlines
    file.close
    file_new=File.new(file_path, 'w+')
    lines.each do |line|
      if line.include? "127.0.1.1"
        if line.to_s.casecmp("127.0.1.1") == 1
          $xaslogger.info "NetworkSet controller/change_hosts_file : linux hosts file changed"
          file_new.puts "127.0.1.1"+"   "+@network_set.hostname
        else
          file_new.puts line
        end
      else
        file_new.puts line
      end
    end
    file_new.close
  end

  private
  def restart_network
    system XCommands::X_L_NETWORK_RESTART
    if $?.exitstatus == 1
      $xaslogger.info "NetworkSet controller/restart_network : network restarted"
    else
      $xaslogger.info "NetworkSet controller/restart_network : network did not restarted"
    end
  end

end
