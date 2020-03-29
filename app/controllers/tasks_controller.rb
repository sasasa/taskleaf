class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @q = current_user.tasks.ransack(params[:q])
    @tasks = @q.result(distinct: true).includes(:project)

    respond_to do |format|
      format.html
      format.csv { send_data @tasks.generate_csv, filename: "tasks-#{Time.zone.now.strftime('%Y%m%d%S')}.csv" }
    end
  end

  def import
    current_user.tasks.import(params[:file])
    redirect_to tasks_url, notice: "タスクを追加しました"
  end

  def show
  end

  def new
    @task = Task.new
    @option_for_select = current_user.projects_option_for_select
  end
  
  def confirm_new
    @task = current_user.tasks.new(task_params)
    unless @task.valid?
      @option_for_select = current_user.projects_option_for_select
      render :new
    end
  end

  def create
    @task = current_user.tasks.new(task_params)

    if params[:back].present?
      @option_for_select = current_user.projects_option_for_select
      render :new
      return
    end

    if @task.save
      TaskMailer.creation_email(@task, current_user).deliver_now
      redirect_to @task, notice: "タスク「#{@task.name}」を登録しました。"
    else
      @option_for_select = current_user.projects_option_for_select
      render :new
    end
  end

  def edit
    @option_for_select = current_user.projects_option_for_select
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_url, notice: "タスク「#{@task.name}」を更新しました。"
    else
      @option_for_select = current_user.projects_option_for_select
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: "タスク「#{@task.name}」を削除しました。"
  end

  private
  def task_params
    params.require(:task).permit(:name, :description, :project_id, :image)
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end
end
