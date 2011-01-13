require 'net/http'
require 'uri'
require 'active_support'

module RwMdnTasks
  def self.deploy(opts = {})
    if RwMdn.configuration.api_url.blank?
      puts "I don't seem to be configured with an Url.  Please check your configuration."
      return false
    end

    if opts[:rails_env].blank?
      puts "I don't know to which Rails environment you are deploying (use the TO=production option)."
      return false
    end
    
    api_url = opts.delete(:api_url) || RwMdn.configuration.api_url
    
    params = {}
    opts.each {|k,v| params["deploy[#{k}]"] = v }

    url = URI.parse(api_url)

    proxy = Net::HTTP.Proxy(RwMdn.configuration.proxy_host,
                            RwMdn.configuration.proxy_port,
                            RwMdn.configuration.proxy_user,
                            RwMdn.configuration.proxy_pass)

    response = proxy.post_form(url, params)

    puts response.body
    return Net::HTTPSuccess === response
  end
end