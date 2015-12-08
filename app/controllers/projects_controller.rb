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
    if @project.update(project_params)
      redirect_to @project, flash: { success: "Project has been updated."}
    else
      render :new, flash: { danger: "Project has not been updated."}
    end
  end

  def my_projects
    @projects = Project.where(user_id: current_user.id)
  end

  def update_tags
    project = Project.find_by_id(params[:project_id])
    tags_ids = params[:tags].split(',').map(&:to_i)
    db_tag_ids = project.tags.map(&:id)

    old_tag_ids = db_tag_ids - tags_ids
    new_tag_ids = tags_ids - db_tag_ids

    tags_to_delete = project.tags.where(id: old_tag_ids)

    tags_to_delete.each do |tag|
      project.tags.delete(tag)
    end

    new_tag_ids.each do |tag_id|
      project.tags.push(Tag.find_by_id(tag_id))
    end

    redirect_to edit_user_registration_path, flash: {success: "Skills updated successfully."}
  end

  private

  def set_project
    @project = Project.find_by_id(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :url, :description)
  end
end
