class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    @user = User.from_omniauth(auth_hash)

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
      flash[:notice] = "Successfully logged in." if is_navigational_format?
    else
      session["devise.github_data"] = auth_hash
      redirect_to root_path
    end
  end

  def failure
    super
    flash[:error] = "Couldn't sign in, try again later."
  end

  protected

  def auth_hash
    request.env["omniauth.auth"]
  end
end
