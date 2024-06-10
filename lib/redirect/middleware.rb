# frozen_string_literal: true

module Redirect
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      @request = Rack::Request.new(env)
      if url = redirect_url(@request.path)
        redirect_to(url)
      else
        @app.call(env)
      end
    end

    def redirect_url(request_path)
      return unless Redirect::Rails.paths

      Redirect::Rails.paths.map do |path, redirect_path|
        return ERB.new(redirect_path).result(binding) if Regexp.new(path).match(request_path)
      end.first
    end

    def redirect_to(uri)
      headers = { "Location": uri,
                  "Content-Type": @request["Content-Type"],
                  "Pragma": "no-cache",
                  "Cache-Control": "no-cache; max-age=0"
                }
      [302, headers, [redirect_message(uri)]]
    end

    def redirect_message(location)
      %Q(Redirecting to <a href="#{location}">#{location}</a>)
    end
  end
end
