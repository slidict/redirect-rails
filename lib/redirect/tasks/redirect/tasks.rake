# frozen_string_literal: true

namespace :redirect do
  desc 'Install redirect-rails'
  task :install do
    target_filepath = Redirect::Rails.yaml_name
    if File.exist?(target_filepath)
      puts "Already exist file. #{target_filepath}"
    else
      FileUtils.cp(Redirect::Rails.original_yaml_name, target_filepath)
      puts "Installed the config. #{target_filepath}"
    end
  end
end
