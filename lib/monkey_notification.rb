require 'net/http'
require 'net/https'
require 'rubygems'
begin
  require 'active_support'
rescue LoadError
  require 'activesupport'
end

require 'monkey_notification_tasks'

require 'monkey_notification/configuration'

require 'monkey_notification/railtie' if defined?(Rails::Railtie)

module MonkeyNotification
  
  def self.initialize
    MonkeyNotification.configure do |config|
      config.environment_name = RAILS_ENV  if defined?(RAILS_ENV)
      config.project_root     = RAILS_ROOT if defined?(RAILS_ROOT)
      config.framework        = "Rails: #{::Rails::VERSION::STRING}" if defined?(::Rails::VERSION)
    end
  end
  
  class << self
    
    attr_accessor :configuration
    
    def configure
      self.configuration ||= Configuration.new
      yield(configuration)
    end
    
  end
  
end

MonkeyNotification.initialize