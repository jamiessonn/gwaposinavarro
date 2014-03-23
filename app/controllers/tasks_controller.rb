class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :authorize, except: [:all]
  # GET /tasks
  # GET /tasks.json
  def all
    @tasks = Task.all.order(due_date: :asc, name: :asc)
  end
  def index
    @tasks = task_model.incomplete.order(due_date: :asc, name: :asc)
  end

  def search
    @tasks = task_model.search_name(params[:search])
  end
  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @comments = @task.comments
    @comment = @task.comments.build
  end

  # GET /tasks/new
  def new
    @task = current_user.tasks.build
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = current_user.tasks.build(task_params)
    @task.is_completed = false;
    
    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'You can do it!' }
        #format.json { render action: 'show', status: :created, location: @task }
      else
        format.html { render action: 'new' }
        #format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
      respond_to do |format|
        if @task.update(task_params)
          format.html { redirect_to @task, notice: 'GAWIN MO NA' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @task.errors, status: :unprocessable_entity }
        end
      end
  end

  def complete
      if Task.ids(params[:task_ids]).update_all(is_completed: true) 
        redirect_to completed_tasks_path  
      else
        redirect_to tasks_path
      end
  end

  def unmark
      if Task.where.not(id: params[:task_ids]).update_all(is_completed: false) 
        redirect_to tasks_path  
      else
        redirect_to completed_tasks_path
      end
  end

  def completed
    @tasks = task_model.completed.order(due_date: :asc, name: :asc)
  end
  # DELETE /tasks/1
  # DELETE /tasks/1.json
  # def destroy
  #   @task.destroy
  #   respond_to do |format|
  #     format.html { redirect_to tasks_url }
  #     format.json { head :no_content }
  #   end
  # end

  def today 
    @tasks = task_model.due_today.order(name: :asc)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:name, :category, :due_date)
    end

    def task_model      
      Task.owner(current_user)
    end
end
