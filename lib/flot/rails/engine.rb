require 'flot/rails/helpers/view_helpers'

module Flot
  module Rails

    class Engine < ::Rails::Engine
      initializer "flot.view_helpers" do
        ActionView::Base.send :include, ViewHelpers
      end
    end
  end
end
