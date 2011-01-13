module RwMdn
  # Used to set up and modify settings for the notifier.
  class Configuration

    OPTIONS = [:api_url, :environment_name, :project_root, :framework, :proxy_host, :proxy_port, :proxy_user, :proxy_pass].freeze

    # The API key for your project, found on the project edit form.
    attr_accessor :api_url
    
    attr_accessor :environment_name
    
    attr_accessor :project_root
    
    attr_accessor :framework
    
    attr_accessor :proxy_host 
    attr_accessor :proxy_port
    attr_accessor :proxy_user 
    attr_accessor :proxy_pass
    
  end
end