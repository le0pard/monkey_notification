require File.expand_path(File.dirname(__FILE__) + "/lib/insert_commands.rb")

class MonkeyNotificationGenerator < Rails::Generator::Base
  
  def add_options!(opt)
    opt.on('-k', '--api-url=url', String, "Your Monkey URL")                                 {|v| options[:api_url] = v}
  end
  
  def manifest
    record do |m|
      m.directory 'lib/tasks'
      m.file 'monkey_notification_tasks.rake', 'lib/tasks/monkey_notification_tasks.rake'
      if ['config/deploy.rb', 'Capfile'].all? { |file| File.exists?(file) }
        m.append_to 'config/deploy.rb', capistrano_hook
      end
      if options[:api_url] && !api_url_configured?
        m.template 'initializer.rb', 'config/initializers/monkey_notification.rb',
          :assigns => {:api_url => api_url_expression}
      end
    end
  end
  
  def api_url_configured?
    File.exists?('config/initializers/monkey_notification.rb')
  end
  
  def api_url_expression
    "'#{options[:api_url]}'"
  end
  
  def capistrano_hook
    IO.read(source_path('capistrano_hook.rb'))
  end
  
end