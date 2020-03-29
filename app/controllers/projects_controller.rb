class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    @projects = current_user.projects
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = current_user.projects.new
    @project.tasks.build
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = current_user.projects.new(project_params)
    @project.tasks.first.user = current_user
    if @project.save
      redirect_to @project, notice: "プロジェクト「#{@project.name}」を登録しました。"
    else
      render :new
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    if @project.update(project_params)
      redirect_to @project, notice: "プロジェクト「#{@project.name}」を更新しました。"
    else
      render :edit
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    # redirect_to projects_url, notice: "プロジェクト「#{@project.name}」を削除しました。"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = current_user.projects.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:name, tasks_attributes: [:name])
    end
end
