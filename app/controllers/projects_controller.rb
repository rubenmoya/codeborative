class ProjectsController < ApplicationController
  before_action :set_project, except: [:index, :create]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @projects = Project.all

   if params[:search]
     tags_names = params[:search][:tags].split(',').map(&:strip).map(&:downcase)
     @projects = Project.with_tags(tags_names)
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
  end

  def update
    if @project.update(project_params.except(:tags)) && @project.update_tags(project_params[:tags])
      redirect_to @project, flash: { success: "Project has been updated."}
    else
      render :new, flash: { danger: "Project has not been updated."}
    end
  end

  def my_projects
    @projects = Project.where(user_id: current_user.id)
  end

  private

  def set_project
    @project = Project.find_by_id(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :url, :description, :tags)
  end
end
