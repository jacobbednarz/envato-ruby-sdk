require 'faraday'
require 'json'

module Envato
  module Connection
    def get(url)
      request :get, url
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
        c.authorization(:Bearer, @access_token)
        c.proxy(@proxy) if @proxy
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
