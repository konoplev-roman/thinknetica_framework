# frozen_string_literal: true

require 'erb'

module Framework
  class View
    VIEW_BASE_PATH = 'app/views'

    def initialize(env)
      @env = env
    end

    def render(binding)
      template = File.read(template_path)

      ERB.new(template).result(binding)
    end

    private

    def controller
      @env['framework.controller']
    end

    def action
      @env['framework.action']
    end

    def template
      @env['framework.template']
    end

    def template_path
      path = template || [controller.name, action].join('/')

      Framework.root.join(VIEW_BASE_PATH, "#{path}.html.erb")
    end
  end
end
