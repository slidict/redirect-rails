# frozen_string_literal: true

module Redirect
  # Insert middleware
  class Engine < ::Rails::Engine
    initializer "insert_redirect_middleware" do |app|
      app.middleware.insert_before ActionDispatch::Callbacks, Redirect::Middleware
    end
  end
end
