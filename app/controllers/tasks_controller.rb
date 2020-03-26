class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = current_user.tasks.recent
  end

  def show
  end

  def new
    @task = Task.new
    @option_for_select = current_user.projects.map{|p|[p.name, p.id]}
  end

  def create
    @task = current_user.tasks.new(task_params)

    if @task.save
      redirect_to @task, notice: "タスク「#{@task.name}」を登録しました。"
    else
      @option_for_select = current_user.projects.map{|p|[p.name, p.id]}
      render :new
    end
  end

  def edit
    @option_for_select = current_user.projects.map{|p|[p.name, p.id]}
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_url, notice: "タスク「#{@task.name}」を更新しました。"
    else
      @option_for_select = current_user.projects.map{|p|[p.name, p.id]}
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: "タスク「#{@task.name}」を削除しました。"
  end

  private
  def task_params
    params.require(:task).permit(:name, :description, :project_id)
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end
end
