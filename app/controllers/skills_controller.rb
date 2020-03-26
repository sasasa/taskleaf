class SkillsController < ApplicationController
  before_action :set_skill, only: [:show, :edit, :update, :destroy]

  # GET /skills
  # GET /skills.json
  def index
    @skills = Skill.all
  end

  # GET /skills/1
  # GET /skills/1.json
  def show
  end

  # GET /skills/new
  def new
    @skill = Skill.new
    @options_for_select = Skill.category_options_for_select
  end

  # GET /skills/1/edit
  def edit
    @options_for_select = Skill.category_options_for_select
  end

  # POST /skills
  # POST /skills.json
  def create
    @skill = Skill.new(skill_params)

    if @skill.save
      redirect_to @skill, notice: "スキル「#{@skill.name}」を登録しました。"
    else
      @options_for_select = Skill.category_options_for_select
      render :new
    end
  end

  # PATCH/PUT /skills/1
  # PATCH/PUT /skills/1.json
  def update
    if @skill.update(skill_params)
      redirect_to @skill, notice: "スキル「#{@skill.name}」を更新しました。"
    else
      @options_for_select = Skill.category_options_for_select
      render :edit
    end
  end

  # DELETE /skills/1
  # DELETE /skills/1.json
  def destroy
    @skill.destroy
    redirect_to skills_url, notice: "スキル「#{@skill.name}」を削除しました。"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_skill
      @skill = Skill.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def skill_params
      params.require(:skill).permit(:name, :category)
    end
end
