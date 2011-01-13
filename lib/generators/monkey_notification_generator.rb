class MonkeyNotificationGenerator < Rails::Generators::Base
  
  class_option :api_url, :aliases => "-k", :type => :string, :desc => "Your Monkey Url"
  
  def self.source_root
    File.expand_path("../../../generators/monkey_notification/templates", __FILE__)
  end
  
  def install
    ensure_api_url_was_configured
    append_capistrano_hook
    generate_initializer unless api_url_configured?
  end
  
  private

  def ensure_api_url_was_configured
    if !api_url_configured? && !options[:api_url]
      puts "Must pass --api-url or create config/initializers/monkey_notification.rb"
      exit
    end
  end
  
  def append_capistrano_hook
    if File.exists?('config/deploy.rb') && File.exists?('Capfile')
      append_file('config/deploy.rb', <<-HOOK)

require 'monkey_notification/capistrano'
      HOOK
    end
  end
  
  def api_url_expression
    "'#{options[:api_url]}'"
  end

  def generate_initializer
    template 'initializer.rb', 'config/initializers/monkey_notification.rb'
  end
  
  def api_url_configured?
    File.exists?('config/initializers/monkey_notification.rb')
  end
  
end