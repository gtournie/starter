class Users::RegistrationsController < Devise::RegistrationsController
  include ApplicationHelper

  before_action :configure_permitted_parameters

  def create
    super
  end

  def new
    super
  end

  def edit
    super
  end

protected

  def update_resource(resource, params)
    if resource.email != params[:email] ||
        params[:password].present? ||
        params[:password_confirmation].present?
      resource.update_with_password(params)
    else
      params.delete(:current_password)
      resource.update_without_password(params)
    end
  end

  # my custom fields are :name, :heard_how
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(
        :first_name,
        :last_name,
        :email,
        :password
      )
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(
        :first_name,
        :last_name,
        :email,
        :password,
        :password_confirmation,
        :current_password
      )
    end
  end
end
