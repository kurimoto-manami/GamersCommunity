# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # before_action :user_state, only: [:create]

  def after_sign_in_path_for(resource)
    flash[:notice] = "ログインしました。"
    contributions_path
  end

  def guest_sign_in
    user = User.guest
    sign_in user
    flash[:notice] = "ゲストユーザーとしてログインしました。"
    redirect_to root_path
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
