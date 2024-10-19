# frozen_string_literal: true

module Redirect
  # Redirect::Middleware
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      @request = Rack::Request.new(env)
      if (url = redirect_url(@request.path) || redirect_host(@request.host))
        redirect_to(url)
      else
        @app.call(env)
      end
    end

    private

    def redirect_url(request_path)
      return unless Redirect::Rails.paths

      Redirect::Rails.paths.map do |path, redirect_path|
        return ERB.new(redirect_path).result(binding) if Regexp.new(path).match(request_path)
      end.first
    end

    def redirect_host(request_host)
      return unless Redirect::Rails.hosts

      Redirect::Rails.hosts.map do |host, redirect_url|
        return ERB.new(redirect_url).result(binding) if Regexp.new(host).match(request_host)
      end.first
    end

    def redirect_to(uri)
      headers = { "Location": uri,
                  "Content-Type": @request.content_type,
                  "Pragma": "no-cache",
                  "Cache-Control": "no-cache; max-age=0" }
      [302, headers, [redirect_message(uri)]]
    end

    def redirect_message(location)
      %(Redirecting to <a href="#{location}">#{location}</a>)
    end
  end
end
