require 'faraday'
require 'json'

module Envato
  class Client
    def initialize(options = {})
      if options[:token].nil?
        raise MissingAPITokenError, 'You must define an API token for authorization.'
      end

      @options = options
    end

    def inspect
      inspected = super

      if @options[:token]
        inspected = inspected.gsub! @options[:token], conceal(@options[:token])
      end

      inspected
    end

    def get(url)
      request :get, url
    end

    def conceal(string)
      if string.length < 8
        '****'
      else
        front = string[0, 4]
        back  = string[-4, 4]
        "#{front}****#{back}"
      end
    end

    def proxy?
      (ENV['HTTPS_PROXY'].nil? || ENV['HTTPS_PROXY'].empty?) ? false : true
    end

    def proxy_opts
      (proxy?) ? { uri: ENV['HTTPS_PROXY'] } : nil
    end

    def ssl_opts
      { verify: true }
    end

    def api_host
      'https://api.envato.com'
    end

    def api_version
      'v1'
    end

    private

    def request(method, url, options = {})
      request = Faraday.new(url: api_host, ssl: ssl_opts) do |c|
        c.adapter Faraday.default_adapter
        c.headers['User-Agent'] = "Envato SDK (#{Envato::VERSION})"
        c.authorization(:Bearer, @options[:token])
        c.proxy proxy_opts
      end

      case method
      when :get
        response = request.get "#{api_version}/#{url}"
      end

      begin
        JSON.parse(response.body)
      rescue JSON::ParserError
        response.body
      end
    end
  end
end
