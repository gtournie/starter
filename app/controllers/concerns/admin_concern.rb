module AdminConcern
  extend ActiveSupport::Concern

  included do
    layout 'admin'
    before_action :authenticate_admin!
  end
end