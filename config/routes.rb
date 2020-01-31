# frozen_string_literal: true

Framework.application.routes do
  get '/tests', 'tests#index'
  post '/tests', 'tests#create'
end
