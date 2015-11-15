require 'envato/connection'
require 'envato/configurable'

module Envato
  class Client

    include Envato::Connection
    include Envato::Configurable

    def initialize(options = {})
      Envato::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", options[key] || Envato.instance_variable_get(:"@#{key}"))
      end

      if @access_token.nil?
        raise Envato::MissingAPITokenError, 'You must define an API access token for authorization.'
      end
    end

    def inspect
      inspected = super

      if @access_token
        inspected = inspected.gsub! @access_token, conceal(@access_token)
      end

      inspected
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
  end
end
