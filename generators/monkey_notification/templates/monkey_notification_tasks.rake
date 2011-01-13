unless ARGV.any? {|a| a =~ /^gems/} 

  Dir[File.join(RAILS_ROOT, 'vendor', 'gems', 'monkey_notification-*')].each do |vendored_notifier|
    $: << File.join(vendored_notifier, 'lib')
  end

  begin
    require 'monkey_notification/tasks'
  rescue LoadError => exception
    namespace :hoptoad do
      %w(deploy test).each do |task_name|
        desc "Missing dependency for monkey_notification:#{task_name}"
        task task_name do
          $stderr.puts "Failed to run monkey_notification:#{task_name} because of missing dependency."
          $stderr.puts "You probably need to run `rake gems:install` to install the monkey_notification gem"
          abort exception.inspect
        end
      end
    end
  end

end