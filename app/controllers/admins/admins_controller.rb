class Admins::AdminsController < ApplicationController
  include AdminConcern

  helper_method :admins, :admin

  def create
    save
  end

  def update
    save
  end

private

  def save
    admin.update_attributes(admin_params)
    respond_with admin, location: -> { admin_admins_path }
  end

  def interpolation_options
    { resource_name: admin.name }
  end

  def admins
    @admins ||= Admin.sorted({ sort: params[:sort], order: [:last_name, :first_name] }).page(params[:page])
  end

  def admin
    @admin ||= params.has_key?(:id) ? Admin.find(params[:id]) : Admin.new
  end

  def admin_params
    params.require(:admin).permit(
        :first_name,
        :last_name,
        :email,
        :password,
        :password_confirmation)
    # admin can't change his own password from here. See registrations_controller.
    admin != current_admin ? params : params.except(:password, :password_confirmation)
  end
end