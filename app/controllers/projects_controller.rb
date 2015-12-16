class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    if params[:search]
      tags_names = params[:search][:tags].split(',').map(&:strip).map(&:downcase)
      @projects = Project.with_tags(tags_names)
    else
      @latest_projects = true
      @projects = Project.all.limit(4)
    end
  end

  def new
    @project = current_user.projects.build()
  end

  def create
    @project = current_user.projects.new(project_params)

    if @project.save
      redirect_to @project, flash: { success: "Project has been created."}
    else
      render :new, flash: { danger: "Project has not been created."}
    end
  end

  def show
    @user = @project.user
  end

  def edit
    @tag_list = @project.my_tags
  end

  def update
    if @project.update(project_params)
      redirect_to @project, flash: { success: "Project has been updated."}
    else
      render :new, flash: { danger: "Project has not been updated."}
    end
  end

  def destroy
    if @project.destroy
      redirect_to my_projects_path, flash: { success: "Project has been deleted."}
    else
      render :new, flash: { danger: "Project has not been deleted."}
    end
  end

  private

  def set_project
    @project = Project.find_by_id(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :url, :description, :tags_list)
  end
end
