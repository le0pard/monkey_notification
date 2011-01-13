require 'rw_mdn'
require 'rails'

module RwMdn
  class Railtie < Rails::Railtie
    rake_tasks do
      require 'rw_mdn/tasks'
    end

    config.after_initialize do
      RwMdn.configure do |config|
        config.environment_name ||= Rails.env
        config.project_root     ||= Rails.root
        config.framework        = "Rails: #{::Rails::VERSION::STRING}"
      end

    end
  end
end