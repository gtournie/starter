require 'bs_columns/view_helpers'
# module BsColumns
#   class Railtie < Rails::Railtie
#     initializer "bs_columns.view_helpers" do
#       ActionView::Base.send :include, ViewHelpers
#     end
#   end
# end

ActionView::Base.send :include, BsColumns::ViewHelpers