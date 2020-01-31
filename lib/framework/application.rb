# frozen_string_literal: true

require 'singleton'
require_relative 'router'
require_relative 'controller'

module Framework
  class Application
    include Singleton

    def initialize
      @router = Router.new
    end

    def bootstrap!
      require_app
      require_routes
    end

    def call(env)
      route = @router.route_for(env)

      controller = route.controller.new(env)
      action = route.action

      make_response(controller, action)
    end

    def routes(&block)
      @router.instance_eval(&block)
    end

    private

    def make_response(controller, action)
      controller.make_response(action)
    end

    def require_app
      Dir["#{Framework.root}/app/**/*.rb"].sort.each { |file| require file }
    end

    def require_routes
      require Framework.root.join('config/routes')
    end
  end
end
