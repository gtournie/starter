module NameConcern
  extend ActiveSupport::Concern

  def name
    "#{last_name.to_s.capitalize} #{first_name.to_s.capitalize}".strip
  end
end