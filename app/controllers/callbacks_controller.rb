class CallbacksController < Devise::OmniauthCallbacksController
  after_action :skip_authorization

  def github
    user = User.from_omniauth(request.env["omniauth.auth"])
    signin_and_redirect(user)
  end

  def gitlab
    user = User.from_omniauth(request.env["omniauth.auth"])
    signin_and_redirect(user)
  end

  private

  def signin_and_redirect(user)
    sign_in user
    if user.default_password
      flash[:notice] = "Please update your password, your security is important to us."
      redirect_to edit_user_registration_path
    else
      flash[:notice] = "Signed in successfully."
      redirect_to root_path
    end
  end
end
