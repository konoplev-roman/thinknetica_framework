# frozen_string_literal: true

class TestsController < Framework::Controller
  def index
    # It is possible to use a custom template
    # render('tests/list')

    @tests = Test.all
  end

  def create; end
end
