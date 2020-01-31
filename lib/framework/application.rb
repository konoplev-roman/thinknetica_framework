# frozen_string_literal: true

require 'singleton'

module Framework
  class Application
    include Singleton

    def call(_env)
      [
        200,
        { 'Content-Type' => 'text/plain' },
        ["Framework in action\n"]
      ]
    end
  end
end
