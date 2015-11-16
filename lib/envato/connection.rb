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

      case response.status.to_i
        when 403      then raise Envato::ForbiddenError, extract_forbidden_message(response)
        when 404      then raise Envato::NotFoundError
        when 405..499 then raise Envato::ClientError
        when 500..599 then raise Envato::ServerError, extract_server_error_message(response)
      end

      begin
        JSON.parse(response.body)
      rescue JSON::ParserError
        response.body
      end
    end

    def extract_forbidden_message(response)
      body = JSON.parse(response.body)
      body['error_description']
    end

    def extract_server_error_message(response)
      body = JSON.parse(response.body)
      body['message']
    end
  end
end
