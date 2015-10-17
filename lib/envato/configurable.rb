module Envato
  module Configurable
    attr_accessor :access_token, :proxy, :username

    class << self
      def keys
        @keys ||= [
          :username,
          :access_token,
          :proxy
        ]
      end
    end

    def configure
      yield self
    end

    private

    def options
      Hash[Envato::Configurable.keys.map{ |key| [key, instance_variable_get(:"@#{key}")] }]
    end
  end
end
