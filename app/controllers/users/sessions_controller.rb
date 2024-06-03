class Users::SessionsController < Devise::SessionsController
  def create
    user = User.find_by(email: params[:user][:email])

    if user && user.valid_password?(params[:user][:password]) && (user.status == nil || user.status == true)
      super
    else
      flash[:alert] = "Your account is blocked or does not exist."
      redirect_to new_user_session_path
    end
  end
end
