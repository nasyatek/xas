class TodoListsController < ApplicationController
  before_action :set_todo_list, only: [:show, :edit, :update, :destroy]

  # GET /todo_lists
  # GET /todo_lists.json
  def index
    @todo_lists = TodoList.all
    $xaslogger.info "TodoList controller/create action : listing todos"
  end

  # GET /todo_lists/1
  # GET /todo_lists/1.json
  def show
  end

  # GET /todo_lists/new
  def new
    @todo_list = TodoList.new
  end

  # GET /todo_lists/1/edit
  def edit
  end

  # POST /todo_lists
  # POST /todo_lists.json
  def create
    @todo_list = TodoList.new(todo_list_params)

    respond_to do |format|
      if @todo_list.save
        format.html { redirect_to @todo_list, notice: t('notice.todo_lists_set_created') }
        format.json { render :show, status: :created, location: @todo_list }
        $xaslogger.info "TodoList controller/create action : todo created"
      else
        format.html { render :new }
        format.json { render json: @todo_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /todo_lists/1
  # PATCH/PUT /todo_lists/1.json
  def update
    respond_to do |format|
      if @todo_list.update(todo_list_params)
        format.html { redirect_to @todo_list, notice: t('notice.todo_lists_set_updated') }
        format.json { render :show, status: :ok, location: @todo_list }
        $xaslogger.info "TodoList controller/update action : todo updated"
      else
        format.html { render :edit }
        format.json { render json: @todo_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todo_lists/1
  # DELETE /todo_lists/1.json
  def destroy
    @todo_list.destroy
    respond_to do |format|
      format.html { redirect_to todo_lists_url, notice: t('notice.todo_lists_set_destroyed') }
      format.json { head :no_content }
      $xaslogger.info "TodoList controller/destroy action : todo destroyed"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo_list
      @todo_list = TodoList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def todo_list_params
      params.require(:todo_list).permit(:note, :active)
    end
end
