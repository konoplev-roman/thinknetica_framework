# frozen_string_literal: true

module Framework
  class Controller
    def initialize(env)
      @request = Rack::Request.new(env)
      @response = Rack::Response.new
    end

    def make_response(action)
      [
        200,
        {
          'Content-Type' => 'text/plain',
          'X-Controller' => self.class.name,
          'X-Action' => action
        },
        ["Framework in action\n"]
      ]
    end
  end
end
