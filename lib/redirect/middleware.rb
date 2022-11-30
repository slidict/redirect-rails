# frozen_string_literal: true

module Redirect
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      @request = Rack::Request.new(env)
      if response = match?(@request.path)
        response
      else
        @app.call(env)
      end
    end

    def match?(request_path)
      Redirect::Rails.paths.map do |path, redirect_path|
        if Regexp.new(path).match(request_path)
          return redirect_to(redirect_path)
        end
      end if Redirect::Rails.paths
      return nil
    end

    def redirect_to(uri)
      headers = { 'Location'      => uri,
                  'Content-Type'  => @request['Content-Type'],
                  'Pragma'        => 'no-cache',
                  'Cache-Control' => 'no-cache; max-age=0' }
      [302, headers, [redirect_message(uri)]]
    end

    def redirect_message(location)
      %Q(Redirecting to <a href="#{location}">#{location}</a>)
    end
  end
end
