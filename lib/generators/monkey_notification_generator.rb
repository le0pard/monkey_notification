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
  
  def api_key_expression
    "'#{options[:api_key]}'"
  end

  def generate_initializer
    template 'initializer.rb', 'config/initializers/monkey_notification.rb'
  end


  def manifest
    if !options[:api_url]
      puts "Must pass --api-url"
      exit
    end
    record do |m|
      m.directory 'lib/tasks'
      m.file 'monkey_notification_tasks.rake', 'lib/tasks/monkey_notification_tasks.rake'
      if ['config/deploy.rb', 'Capfile'].all? { |file| File.exists?(file) }
        m.append_to 'config/deploy.rb', capistrano_hook
      end
      if api_key_expression
        m.template 'initializer.rb', 'config/initializers/monkey_notification.rb',
            :assigns => {:api_url => api_url_expression}
      end
      #m.rake "hoptoad:test --trace", :generate_only => true
    end
  end
  
  def api_url_expression
    "'#{options[:api_url]}'"
  end
  
end