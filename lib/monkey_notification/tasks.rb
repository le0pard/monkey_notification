namespace :monkey_notification do
  desc "Notify Monkey about a new deploy."
  task :deploy => :environment do
    require 'monkey_notification_tasks'
    MonkeyNotificationTasks.deploy(:rails_env      => ENV['TO'],
                        :scm_revision   => ENV['REVISION'],
                        :scm_repository => ENV['REPO'],
                        :local_username => ENV['USER'],
                        :branch         => ENV['BRANCH'],
                        :main_server    => ENV['MAIN_SERVER'],
                        :api_url        => ENV['API_URL'])
  end
end