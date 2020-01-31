# frozen_string_literal: true

require_relative 'framework/application'

module Framework
  class << self
    def application
      Application.instance
    end
  end
end
