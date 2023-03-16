class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  def index
    @projects = current_user.projects.where(:is_paid => true)
  end

  def show
    @project = Project.find(params[:id])
    @task = Task.new(project: @project)
    @tasks = @project.tasks.order(:created_at)
    render 'show'
  end

  def new
    @project = current_user.projects.build
  end

  def edit
  end
  def create
    @project = current_user.projects.build(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to root_path, notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: @project }
      else
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to project_url(@project), notice: "Project was successfully updated." }
        format.json { render :show, status: :ok, location: @project }
      else
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url, notice: "Project was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_project
      @project = current_user.projects.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:name, :description)
    end
  end 