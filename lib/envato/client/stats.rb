module Envato
  class Client
    module Stats
      def total_users
        response = get 'market/total-users.json'
        response['total-users']['total_users']
      end
    end
  end
end
