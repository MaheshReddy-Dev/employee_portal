class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = @project.tasks
  end

  def show
  end


  def new
    @task = @project.tasks.build
  end

  def edit
  end

  def create
    @task = @project.tasks.build(task_params)

    if @task.save
      redirect_to(@task.project)
    else
      render action: 'new'
    end
  end

  def update
    if @task.update(task_params)
      redirect_to(@task.project)
    else

      format.turbo_stream { render :form_update, status: :unprocessable_entity }
      render action: 'edit'
    end
  end

  def destroy
    @task.destroy

    redirect_to @project
  end

  private
    def set_project
      @project = current_user.projects.find(params[:project_id])
    end

    def set_task
      @task = @project.tasks.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:name, :description, :status, :project_id)
    end
end
