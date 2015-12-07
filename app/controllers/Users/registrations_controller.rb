class Users::RegistrationsController < Devise::RegistrationsController
before_filter :configure_sign_up_params, only: [:create]
before_filter :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  def update_skills
    skills_ids = params[:skills].split(',').map(&:to_i)
    db_skill_ids = current_user.skills.map(&:id)

    old_skill_ids = db_skill_ids - skills_ids
    new_skill_ids = skills_ids - db_skill_ids

    skills_to_delete = current_user.skills.where(id: old_skill_ids)

    skills_to_delete.each do |skill|
      current_user.skills.delete(skill)
    end

    new_skill_ids.each do |skill_id|
      current_user.skills.push(Skill.find_by_id(skill_id))
    end

    redirect_to edit_user_registration_path, flash: {success: "Skills updated successfully."}
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.for(:sign_up).push(:name, :location, :company, :description, :twitter, :github)
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.for(:account_update).push(:name, :location, :company, :description, :twitter, :github)
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
