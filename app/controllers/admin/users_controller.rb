class Admin::UsersController < ApplicationController
  before_action :require_admin

  def edit
    @user = User.find(params[:id])
    @skill_ids = Skill.skill_ids
    @init_ids = @user.init_skill_ids
  end

  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    @skill_ids = Skill.skill_ids
    @init_ids = @user.init_skill_ids
  end

  def create
    logger.debug(user_params[:skill_id])
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "ユーザー「#{@user.name}」を登録しました。"
    else
      @skill_ids = Skill.skill_ids
      @init_ids = @user.init_skill_ids
      render :new
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "ユーザー「#{@user.name}」を更新しました。"
    else
      @skill_ids = Skill.skill_ids
      @init_ids = @user.init_skill_ids
      render :new
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_url, notice: "ユーザー「#{@user.name}」を削除しました。"
  end

  def edit_proficiency
    @user = User.find(params[:id])
    @skills_users = @user.skills_users
  end

  def update_proficiency
    @user = User.find(params[:id])
    @user.setProficiency!(params[:skills_user])
    
    redirect_to edit_proficiency_admin_user_path(@user)
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation, :locale, skill_ids: [])
  end

  def require_admin
    redirect_to root_path unless current_user.admin?
  end
end
