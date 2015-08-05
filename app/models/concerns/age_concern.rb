module AgeConcern
  extend ActiveSupport::Concern

  def age
    return nil unless birthday
    ((Date.today - birthday) / 365).floor
  end
end