require 'net/http'
require 'uri'
require 'active_support'

module MonkeyNotificationTasks
  def self.deploy(opts = {})
    if MonkeyNotification.configuration.api_url.blank?
      puts "I don't seem to be configured with an Url.  Please check your configuration."
      return false
    end

    if opts[:rails_env].blank?
      puts "I don't know to which Rails environment you are deploying (use the TO=production option)."
      return false
    end
    
    api_url = opts.delete(:api_url) || MonkeyNotification.configuration.api_url
    
    params = {}
    opts.each {|k,v| params["deploy[#{k}]"] = v }

    url = URI.parse(api_url)

    proxy = Net::HTTP.Proxy(MonkeyNotification.configuration.proxy_host,
                            MonkeyNotification.configuration.proxy_port,
                            MonkeyNotification.configuration.proxy_user,
                            MonkeyNotification.configuration.proxy_pass)

    response = proxy.post_form(url, params)

    puts response.body
    return Net::HTTPSuccess === response
  end
end