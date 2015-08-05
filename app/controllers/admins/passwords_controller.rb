class Admins::PasswordsController < Devise::PasswordsController
  include ApplicationHelper

  layout 'admin'

  def new
    super
  end
end
