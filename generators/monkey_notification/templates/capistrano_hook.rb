Dir[File.join(File.dirname(__FILE__), '..', 'vendor', 'gems', 'monkey_notification-*')].each do |vendored_notifier|
  $: << File.join(vendored_notifier, 'lib')
end

require 'monkey_notification/capistrano'