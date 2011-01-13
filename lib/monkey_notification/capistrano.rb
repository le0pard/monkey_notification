# Defines deploy:rw_mdn:notify which will send information about the deploy to Monkey.

Capistrano::Configuration.instance(:must_exist).load do
  after "deploy",            "deploy:monkey_notification:notify"

  namespace :deploy do
    namespace :monkey_notification do
      desc "Notify Monkey of the deployment"
      task :notify, :except => { :no_release => true } do
        rails_env = fetch(:rails_env, "production")
        branch = fetch(:branch, "HEAD")
        main_server = fetch(:main_server, "N/A")
        local_user = ENV['USER'] || ENV['USERNAME']
        executable = RUBY_PLATFORM.downcase.include?('mswin') ? 'rake.bat' : 'rake'
        notify_command = "#{executable} rw_mdn:deploy TO=#{rails_env} REVISION=#{current_revision} REPO=#{repository} USER=#{local_user} BRANCH=#{branch} MAIN_SERVER=#{main_server}"
        notify_command << " API_URL=#{ENV['API_URL']}" if ENV['API_URL']
        puts "Notifying Monkey of Deploy (#{notify_command})"
        `#{notify_command}`
        puts "Monkey Notification Complete."
      end
    end
  end
end