class Admins::SessionsController < Devise::SessionsController
  include ApplicationHelper

  layout 'admin'
  
  def create
    super
  end

  def new
    super
  end
end
