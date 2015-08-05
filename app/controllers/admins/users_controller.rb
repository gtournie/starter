class Admins::UsersController < ApplicationController
  include AdminConcern

  helper_method :users, :user

  def create
    save
  end

  def update
    save
  end

private

  def save
    user.update_attributes(user_params)
    respond_with user, location: -> { admin_users_path }
  end

  def interpolation_options
    { resource_name: user.name }
  end

  def users
    @users ||= User.sorted({ sort: params[:sort], order: [:last_name, :first_name] }).page(params[:page])
  end

  def user
    @user ||= params.has_key?(:id) ? User.find(params[:id]) : User.new
  end

  def user_params
    params.require(:user).permit(
        :first_name,
        :last_name,
        :email,
        :password,
        :password_confirmation)
  end
end