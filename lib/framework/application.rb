# frozen_string_literal: true

require 'singleton'
require 'yaml'
require 'sequel'
require_relative 'router'
require_relative 'controller'

module Framework
  class Application
    include Singleton

    attr_reader :db

    def initialize
      @router = Router.new
      @db = nil
    end

    def bootstrap!
      setup_database
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

    def setup_database
      database_config = YAML.load_file(Framework.root.join('config/database.yml'))
      database_config['database'] = Framework.root.join(database_config['database'])

      @db = Sequel.connect(database_config)
    end

    def require_app
      Dir["#{Framework.root}/app/**/*.rb"].sort.each { |file| require file }
    end

    def require_routes
      require Framework.root.join('config/routes')
    end
  end
end
