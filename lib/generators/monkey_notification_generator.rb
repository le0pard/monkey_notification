class MonkeyNotificationGenerator < Rails::Generators::Base
  
  class_option :api_url, :aliases => "-k", :type => :string, :desc => "Your Monkey Url"
  
  source_root File.expand_path("../templates", __FILE__)
  
  def install
    ensure_api_url_was_configured
    append_capistrano_hook
    generate_initializer
  end
  
  private

  def ensure_api_url_was_configured
    if !options[:api_url]
      puts "Must pass --api-url"
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
  
end