# frozen_string_literal: true

require "abstract_controller"
require "abstract_controller/railties/routes_helpers"
require "action_controller"
require "action_dispatch"

SharedTestRoutes = ActionDispatch::Routing::RouteSet.new

SharedTestRoutes.draw do
  ActiveSupport::Deprecation.silence do
    get ":controller(/:action)"
  end
end

module ActionDispatch
  module SharedRoutes
    def before_setup
      @routes = SharedTestRoutes
      super
    end
  end
end

module ActionController
  class TestCase
    include ActionDispatch::TestProcess
    include ActionDispatch::SharedRoutes
  end
end

