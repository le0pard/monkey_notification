require 'monkey_notification'
require 'rails'

module MonkeyNotification
  class Railtie < Rails::Railtie
    rake_tasks do
      require 'monkey_notification/tasks'
    end

    config.after_initialize do
      MonkeyNotification.configure do |config|
        config.environment_name ||= Rails.env
        config.project_root     ||= Rails.root
        config.framework        = "Rails: #{::Rails::VERSION::STRING}"
      end

    end
  end
end