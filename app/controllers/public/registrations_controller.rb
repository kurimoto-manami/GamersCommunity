# frozen_string_literal: true

class Public::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  before_action :user_state, only: [:create]

  def after_sign_in_path_for(resource)
    flash[:notice] = "新規登録に成功しました。"
    user_path(current_user)
  end

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

  protected

  def user_params
    params.require(:user).permit(:nickname, :password, :email, :status)
  end
  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :password, :email])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname])
  end

  def user_state
    @user = User.find_by(email: params[:user][:email])
    return if !@user
    if @user.valid_password?(params[:user][:password]) && (@user.is_deleted == false)
    else
      flash[:notice] = "メールアドレスは登録できません。"
      redirect_to new_user_registration_path
    end
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
