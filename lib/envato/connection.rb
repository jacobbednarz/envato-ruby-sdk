require 'faraday'
require 'json'

module Envato
  module Connection
    # Make a raw HTTP GET request.
    #
    # @example Perform a request for logged in username.
    #   @client.get 'v1/market/private/user/username.json'
    #
    # @param url [String] The URL relative to the base domain.
    # @return [Hash] Response from HTTP endpoint.
    def get(url)
      request(:get, url)
    end

    # Definition of all SSL options.
    #
    # @return [Hash] SSL connection options to be used on all connections.
    def ssl_opts
      { verify: true }
    end

    # The API host we are connecting to.
    #
    # @return [String] Full hostnme to perform connections to.
    def api_host
      'https://api.envato.com'
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
        response = request.get(url)
      end

      case response.status.to_i
        when 403      then raise Envato::ForbiddenError, extract_forbidden_message(response)
        when 404      then raise Envato::NotFoundError, extract_not_found_message(response)
        when 405..499 then raise Envato::ClientError
        when 500..599 then raise Envato::ServerError, extract_server_error_message(response)
      end

      begin
        symbolize(JSON.parse(response.body))
      rescue JSON::ParserError
        response.body
      end
    end

    # Extract correct message for 'forbidden' requests.
    #
    # @param response [Faraday::Response] Endpoint response.
    # @return [String] Error message returned from the request payload.
    def extract_forbidden_message(response)
      begin
        body = JSON.parse(response.body)
        body['error_description'] if body['error_description']
      rescue JSON::ParserError
        response.body
      end
    end

    # Extract correct message for 'not found' requests.
    #
    # @param response [Faraday::Response] Endpoint response.
    # @return [String] Error message returned from the request payload.
    def extract_not_found_message(response)
      begin
        body = JSON.parse(response.body)
        body['description'] if body['description']
      rescue JSON::ParserError
        response.body
      end
    end

    # Extract correct message for 'server error' requests.
    #
    # @param response [Faraday::Response] Endpoint response.
    # @return [String] Error message returned from the request payload.
    def extract_server_error_message(response)
      begin
        body = JSON.parse(response.body)
        body['message'] if body['message']
      rescue JSON::ParserError
        response.body
      end
    end

    # Recursively convert strings to symbols.
    #
    # @example Symbolizing hash.
    #   symbolize({'test' => 'value'})
    #   # => { :test => 'value' }
    # @example Symbolizing nested hash.
    #   symbolize({'test' => 'value', 'another' => {'value' => 'example'}})
    #   # => { :test => 'value', :another => { :value => 'example' } }
    #
    # @return [Hash] Converted hash using symbols instead of strings for the
    #   keys.
    def symbolize(obj)
      return obj.reduce({}) do |memo, (k, v)|
        memo.tap { |m| m[k.to_sym] = symbolize(v) }
      end if obj.is_a? Hash

      return obj.reduce([]) do |memo, v|
        memo << symbolize(v); memo
      end if obj.is_a? Array

      obj
    end
  end
end
