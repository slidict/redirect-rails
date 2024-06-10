# frozen_string_literal: true

require "fileutils"
require "yaml"
require_relative "rails/version"
require_relative "engine"
require_relative "middleware"

module Redirect
  module Rails
    class Error < StandardError; end
    class Railtie < ::Rails::Railtie
      rake_tasks do
        load "redirect/tasks/redirect/tasks.rake"
      end
    end

    class << self
      def root
        File.expand_path '../../..', __FILE__
      end

      def paths
        YAML.safe_load(File.read(yaml_name))['paths']
      end

      def original_yaml_name
        "#{Redirect::Rails.root}/config/redirect.yml"
      end

      def yaml_name
        "#{::Rails.root}/config/redirect.yml"
      end
    end
  end
end
