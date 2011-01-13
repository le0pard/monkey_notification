<% if Rails::VERSION::MAJOR < 3 && Rails::VERSION::MINOR < 2 -%>
require 'monkey_notification'
<% end -%>
MonkeyNotification.configure do |config|
  config.api_url = <%= api_url_expression %>
end