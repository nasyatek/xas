class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all
    $xaslogger.info "Group controller/index action : listing groups "
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: t('notice.groups_set_created') }
        format.json { render :show, status: :created, location: @group }
        $xaslogger.info "Group controller/create action : New group created"
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: t('notice.groups_set_updated') }
        format.json { render :show, status: :ok, location: @group }
        $xaslogger.info "Group controller/update action : Group updated"
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: t('notice.groups_set_destroyed') }
      format.json { head :no_content }
      $xaslogger.info "Group controller/destroy action : Group "
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_group
    @group = Group.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def group_params
    params.require(:group).permit(:name, :index_number, :note, :status)
  end

end
